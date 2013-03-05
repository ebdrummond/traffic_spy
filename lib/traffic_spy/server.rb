require 'sinatra/base'

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
      erb :index
    end

    post '/sources' do
      @identifier = params[:identifier]
      @rootUrl = params[:rootUrl]
      if !@identifier || !@rootUrl
        status 400
        body "Sorry, but your request is missing required parameters.  Please try again."
      elsif Account.exists?(@identifier)
        @exists = true
        status 403
        body "Sorry, but #{@identifier} already exists in our database."
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
      elsif Account.exists?(@identifier) == false
        status 403
        body "This application is not yet registered.  Please register and try again."
      end
    end

    get '/sources/:identifier' do
      @identifier = params[:identifier]
      if Account.exists?(@identifier)
        @sorted_urls = Url.sorted_urls(@identifier)
        @browser_breakdown = Browser.breakdown(@identifier)
        @os_breakdown = OperatingSystem.breakdown(@identifier)
        @resolution_breakdown = Resolution.breakdown(@identifier)
        @avg_response_times = Url.average_response_times(@identifier)
        erb :sources
      else
        erb :identifier_error
      end
    end

    get '/sources/:identifier/events' do
      @identifier = params[:identifier]
      if Event.sorted_events(@identifier).all?{|event, count| event == ""}
        erb :event_error
      elsif Account.exists?(@identifier)
        @sorted_events = Event.sorted_events(@identifier)
        erb :event
      else
        erb :identifier_error
      end
    end

    get '/sources/:identifier/events/:event_name' do
      @identifier = params[:identifier]
      @event_name = params[:event_name]
      if Event.sorted_events(@identifier).any?{|event, count| event == @event_name}
        @reg_times = Event.registration_times(@identifier, @event_name)
        erb :event_details
      else
        erb :event_name_error
      end
    end

    get '/sources/:identifier/urls/*' do
      @identifier = params[:identifier]
      @path = "/" + params[:splat][0]
      @url_exists = Url.exists?(@path)
      if @url_exists
        @response_times = Url.response_times(@identifier, @path)
      end
      erb :urls
    end

    post '/sources/:identifier/campaigns' do
      @identifier = params[:identifier]
      @campaign = params[:campaignName].to_s
      @events = params[:eventNames]
      if @campaign == ""
        status 400
        body "Sorry, but your request is missing required parameters.  Please try again."
      elsif @events == nil || @events.empty?
        status 400
        body "Sorry, but your request is missing required parameters.  Please try again."
      elsif Campaign.exists?(@campaign)
        status 403
        body "Sorry, but #{@campaign} already exists in our database."
      elsif Account.exists?(@identifier)
        campaign = Campaign.new(@campaign)
        campaign.register
        campaign_id = Campaign.get_id(@campaign)

        @events.each do |event|
          if Event.exists?(event) == false
            new_event = Event.new(event)
            new_event.register
            new_event_id = Event.get_id(event)
            campaign_event = CampaignEvent.new(@identifier, campaign_id, new_event_id)
            campaign_event.register
          else
            event_id = Event.get_id(event)
            campaign_event = CampaignEvent.new(@identifier, campaign_id, event_id)
            campaign_event.register
          end
        end
        status 200
        body 'Thanks! Information is available in your dashboard.'
      else
        status 400
        body "Something went wrong. Try again."
      end
    end

    get '/sources/:identifier/campaigns' do
      @identifier = params[:identifier]
      if CampaignEvent.any?(@identifier)
        @exists = true
        @campaigns_and_events = CampaignEvent.campaign_event_count(@identifier)
      end
      erb :campaigns
    end

    get '/sources/:identifier/campaigns/:campaign' do
      @identifier = params[:identifier]
      @campaign = params[:campaign]
      @campaign_events = CampaignEvent.campaign_events(@identifier, @campaign)
      erb :campaign_events
    end

    not_found do
      erb :event_error
    end
  end
end