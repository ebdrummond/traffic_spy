require 'spec_helper'

module TrafficSpy
  describe Request do
    it "exists" do
      Request.should be
    end

    before(:each) do
      @input = {
          "url" => "http://jumpstartlab.com/blog",
          "requestedAt" => "2013-02-16 21:38:28 -0700",
          "respondedIn" => 37,
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

    it "takes in the JSON data" do
      instance = Request.new(@input)
      expect(instance.json_input).to eq @input
    end

    it "receives a clean RequestParser object" do
      clean_data = RequestParser.parse_json(@input)
      expect(clean_data).to be_a_kind_of (Hash)
    end
  end
end