require 'spec_helper'

module TrafficSpy
  def app
    Sinatra::Application
  end

  describe Server do
    it "exists" do
      Server.should be
    end

    # it "should load the home page" do
    #   get '/'
    #   last_response.should be_ok
    # end
  end
end