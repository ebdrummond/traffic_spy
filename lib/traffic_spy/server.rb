require 'sinatra'


module TrafficSpy

  # Sinatra::Base - Middleware, Libraries, and Modular Apps
  #
  # Defining your app at the top-level works well for micro-apps but has
  # considerable drawbacks when building reusable components such as Rack
  # middleware, Rails metal, simple libraries with a server component, or even
  # Sinatra extensions. The top-level DSL pollutes the Object namespace and
  # assumes a micro-app style configuration (e.g., a single application file,
  # ./public and ./views directories, logging, exception detail page, etc.).
  # That's where Sinatra::Base comes into play:
  #
  class Server < Sinatra::Base
    set :views, 'lib/views'
    set :public_folder, 'lib/public'

    get '/' do
      #'hello'
      erb :index
    end

    post '/sources' do
      @identifier = params[:identifier]
      @rootUrl = params[:rootUrl]
      if Account.exists?(@identifier)
        @exists = true
        status 403
        body "Sorry, but #{@identifier} already exists in our database."
      elsif (@identifier || @rootUrl).nil?
        status 400
        body "Sorry, but your request is missing required parameters.  Please try again."
      else
        @exists = false
        account = Account.new(@identifier, @rootUrl)
        account.register
        status 200
        body '{"identifier":"' + @identifier +'"}'
      end
    end

    post '/sources/:identifier/data' do
      @identifier = params[:identifier]
      payload_ruby_hash = Payload.parse(params[:payload])
      #do missing params come in as an empty string or nil?  nil breaking shit.
      #check if payload.exists? okay to leave as checking identical time
      if Payload.params_missing?(payload_ruby_hash) == true
        status 400
        body "Sorry, but your request is missing required parameters.  Please try again."
      elsif Account.exists?(@identifier) && Payload.new?(payload_ruby_hash)
        payload = Payload.new(payload_ruby_hash, @identifier)
        payload.register
        status 200
        body "Thanks!  Information is available for review in your dashboard."
      elsif Account.exists?(@identifier) && Payload.new?(payload_ruby_hash) == false
        status 403
        body "Sorry, but this payload already exists in our database."
      end
    end

    get '/sources/:identifier' do
      @identifier = params[:identifier]
      erb :sources
    end

    get '/sources/:identifier/urls/:relative/:path' do
      erb :urls, :locals => { :identifier => params[:identifier],
                              :relative   => params[:relative],
                              :path       => params[:path]  }
    end    

    not_found do
      erb :error
    end
  end
end