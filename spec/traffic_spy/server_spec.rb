require 'spec_helper'
require 'rack/test'
require 'json'

module TrafficSpy
  describe Server do
    include Rack::Test::Methods

    def app
      TrafficSpy::Server
    end

    it "exists" do
      Server.should be
    end

    describe "registration" do
      before(:each) do
        Account.destroy_all
      end

      context "missing params" do
        it "returns a 400 bad request status when missing the identifier" do
          post '/sources', {:rootUrl => "http://erin.com"}
          expect(last_response.status).to eq 400
        end

        it "returns a 400 bad request status when missing both the rootUrl and identifier" do
          post '/sources', {}
          last_response.status.should eq 400
        end

        it "returns 400 complaining about the missing :rootURL" do
          post '/sources', {:identifier => 'identifier'}
          last_response.status.should eq 400
        end
      end

      context "when the identifier is already taken" do
        it "returns 403 with a message" do
          post '/sources', {:identifier => 'erin', :rootUrl => "http://erin.com"}
          post '/sources', {:identifier => 'erin', :rootUrl => "http://erin.com"}
          last_response.status.should eq 403
          last_response.body.should include("already exists")
        end
      end

      context "when there are valid and unique parameters" do
        it "returns 200 with the correct message" do
          post '/sources', {:identifier => 'erin', :rootUrl => "http://erin.com"}
          last_response.status.should eq 200
          last_response.body.should include('{"identifier":"erin"}')
        end
      end
    end

    describe "payload" do

      before(:each) do
      Account.destroy_all
      Payload.destroy_all
      @payload = {
          "url" => "http://jumpstartlab.com/ballin",
          "requestedAt" => "2013-02-16 21:38:26 -0700",
          "respondedIn" => 30,
          "referredBy" => "http://jumpstartlab.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "socialLogin",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211" 
        }.to_json
        @payload_missing = {
          "url" => "",
          "requestedAt" => "2013-02-16 21:38:26 -0700",
          "respondedIn" => 30,
          "referredBy" => "http://jumpstartlab.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "someEvent",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211" 
        }.to_json
        @payload_missing_event = {
          "url" => "someurl",
          "requestedAt" => "2013-02-16 21:38:26 -0700",
          "respondedIn" => 30,
          "referredBy" => "http://jumpstartlab.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211" 
        }.to_json
      end

      context "when a parameter is missing" do
        it "returns with a 400 message" do
          post '/sources/erin/data', {:payload => @payload_missing }
          last_response.status.should eq 400
        end
      end

      context "when the account exists and the payload is new" do
        it "returns a 200 status message" do
          Account.new("erin", "http://www.erin.com").register
          post '/sources/erin/data', {:payload => @payload }
          last_response.status.should eq 200
        end
      end

      context "when the account exists and the payload is not new" do
        it "returns a 403 status message" do
          Account.new("erin", "http://www.erin.com").register
          2.times { post '/sources/erin/data', {:payload => @payload } }
          last_response.status.should eq 403
        end
      end

      context "when the account doesn't exist" do
        it "returns a 403 status message" do
          post '/sources/erin/data', {:payload => @payload }
          last_response.status.should eq 403
        end
      end
    end

    describe "identifier pages" do
      context "when the account exists" do
        it "returns a 200 status message" do
          Account.new("erin", "http://www.erin.com").register
          get '/sources/erin', {}
          last_response.status.should eq 200
        end
      end

      context "when the account doesn't exist" do
        it "returns a 403 status message" do
          get '/sources/aosidhasd', {}
          last_response.status.should eq 403
        end
      end
    end

    describe "event pages" do
      context "when all of the events are empty" do
        it "returns a 403 status message" do
          Account.destroy_all
          Event.destroy_all
          Account.new("erin", "http://www.erin.com").register
          post '/sources/erin/data', {:payload => @payload_missing_event }
          get '/sources/erin', {}
          last_response.status.should eq 403
        end
      end
    end

    describe "urls pages" do
      context "when the url exists" do
        it "returns a 200 status message" do
          Account.new("erin", "http://www.erin.com").register
          post '/sources/erin/data', {:payload => @payload }
          get '/sources/erin/urls/ballin', {}
          last_response.status.should eq 200
        end 
      end
    end

    describe "campaigns pages" do

      before(:each) do
        Campaign.destroy_all
        Event.destroy_all
        @payload = {
          "url" => "http://jumpstartlab.com/ballin",
          "requestedAt" => "2013-02-16 21:38:26 -0700",
          "respondedIn" => 30,
          "referredBy" => "http://jumpstartlab.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "socialLogin",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211" 
        }.to_json
      end

      context "when the campaign is empty of nil" do
        it "returns a 400 status message" do
          Account.new("erin", "http://www.erin.com").register
          post '/sources/erin/campaigns', {:campaignName => "some_campaign"}
          last_response.status.should eq 400
        end
      end

      context "when the campign is empty or nil" do
        it "returns a 400 status message" do
          Account.new("erin", "http://www.erin.com").register
          post '/sources/erin/campaigns', {:eventNames => "some_events"}
          last_response.status.should eq 400
        end
      end

      context "when the campaign already exists" do
        it "returns a 403 status message" do
          Account.new("someguy", "http://www.erin.com").register
          post '/sources/someguy/campaigns', { :campaignName => "some_campaign",
                                            :eventNames => "some_events"}
          post '/sources/someguy/campaigns', { :campaignName => "some_campaign",
                                            :eventNames => "some_events"}
          last_response.status.should eq 403                                  
        end
      end

      context "when the account exists and no params are missing" do
        it "registers everything" do
          Account.new("erin", "http://www.erin.com").register
          post '/sources/erin/data', {:payload => @payload }
          post '/sources/erin/campaigns', { :campaignName => "some_campaign",
                                            :eventNames => "some_events"}
          last_response.status.should eq 200
        end
      end

      context "when the account exists and no params are missing" do
        it "registers everything" do
          Account.new("erin", "http://www.erin.com").register
          post '/sources/erin/data', {:payload => @payload }
          post '/sources/erin/campaigns', { :campaignName => "some_campaign",
                                            :eventNames => "some_events"}
          post '/sources/erin/campaigns', { :campaignName => "new_campaign",
                                            :eventNames => "some_events"}
          last_response.status.should eq 200
        end
      end

      context "when the account doesn't exist and no params are missing" do
        it "returns a 400 status message" do
          post '/sources/anything/campaigns', { :campaignName => "some_campaign",
                                            :eventNames => "some_events"}
          last_response.status.should eq 400
        end
      end
    end

    describe "campaigns pages" do
      before(:each) do
        Campaign.destroy_all
        Event.destroy_all
        @payload = {
          "url" => "http://jumpstartlab.com/ballin",
          "requestedAt" => "2013-02-16 21:38:26 -0700",
          "respondedIn" => 30,
          "referredBy" => "http://jumpstartlab.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "socialLogin",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211" 
        }.to_json
      end

      context "when a campaign event exists" do
        it "returns a 200 status message" do
          Account.new("someone", "http://www.someone.com").register
          post '/sources/someone/data', {:payload => @payload }
          post '/sources/someone/campaigns', { :campaignName => "some_campaign",
                                            :eventNames => "some_events"}
          get '/sources/someone/campaigns', {}
          last_response.status.should eq 200
        end
      end

      context "when someone goes to the specific campaign page" do
        it "returns a 200 status message" do
          Account.new("erin", "http://www.erin.com").register
          post '/sources/erin/data', {:payload => @payload }
          post '/sources/erin/campaigns', { :campaignName => "some_campaign",
                                            :eventNames => "some_events"}
          get '/sources/erin/campaigns/some_campaign', {}
          last_response.status.should eq 200
        end
      end
    end

    it "should load the home page" do
      get '/'
      last_response.should be_ok
    end
  end
end