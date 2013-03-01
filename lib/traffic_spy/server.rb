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
  class Server# < Sinatra::Base
    set :views, '../views'
    set :public, '../public'

    get '/' do
      #'hello'
      erb :index
    end

    post '/sources/:identifier/data' do
      payload = PayloadParser.parse(params)
      payload.url
    end

    get '/sources/:identifier' do
      erb :sources, :locals => {:identifier => params[:identifier]}
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