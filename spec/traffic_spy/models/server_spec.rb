require 'spec_helper'
require 'rack/test'

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

    it "should load the home page" do
      get '/'
      last_response.should be_ok
    end
  end
end