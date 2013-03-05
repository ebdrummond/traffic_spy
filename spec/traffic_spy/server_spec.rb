require 'spec_helper'
require 'rack/test'

module TrafficSpy
  include Rack::Test::Methods

  def app
    Server
  end

  describe Server do
    it "exists" do
      Server.should be
    end
  end

  # describe "registration" do
  #   context "missing params" do
  #     it "returns a 400 bad request status when missing the identifier" do
  #       post '/sources', :rootUrl => "http://erin.com"
  #       expect(last_response.status).to eq 400
  #     end

  #     it "returns a 400 bad request status when missing the rootUrl" do
  #       @account = Account.new("jumpstartlab", "http://jumpstartlab.com")
  #       post '/sources', params = {identifier => 'jumpstartlab'}
  #       last_response.status.should eq 400
  #     end

  #     it "returns a message with the bad request status" do
  #       post '/sources', params = {identifier: 'identifier'}
  #       last_response.status.should eq 400
  #     end
  #   end
  #end


    # it "should load the home page" do
    #   get '/'
    #   last_response.should be_ok
    # end
end