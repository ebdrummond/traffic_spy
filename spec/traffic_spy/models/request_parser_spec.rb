require 'spec_helper'

module TrafficSpy
  describe RequestParser do
    it "exists" do
      RequestParser.should be
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

    describe ".parse_json" do
      it "exists" do
        expect {RequestParser.parse_json(@input)}.to_not raise_exception
      end

      it "parses JSON data to a readable Ruby hash" do
        expect(RequestParser.parse_json(@input)).to be_a_kind_of (Hash)
      end
    end

    it "stores the parsed JSON into class instance variables" do
      data = RequestParser.parse_json(@input)
      request = RequestParser.new(data)
      expect(request.url).to eq "http://jumpstartlab.com/blog"
    end
  end
end