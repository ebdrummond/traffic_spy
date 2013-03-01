require 'spec_helper'

module TrafficSpy
  describe PayloadParser do
    it "exists" do
      PayloadParser.should be
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

    describe ".parse" do
      it "exists" do
        expect {PayloadParser.parse(@input)}.to_not raise_exception
      end

      it "parses JSON data to a readable Ruby hash" do
        payload = PayloadParser.parse(@input)
        expect(payload).to be_a_kind_of(PayloadParser::Payload)
      end
    end

    it "stores the parsed JSON into class instance variables" do
      payload = PayloadParser.parse(@input)
      expect(payload.url).to eq "http://jumpstartlab.com/blog"
    end
  end
end