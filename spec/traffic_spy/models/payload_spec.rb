require 'spec_helper'

module TrafficSpy
  describe Payload do
    it "exists" do
      Payload.should be
    end
    let (:payload_instance) { Payload.new (@payload) }
    before(:each) do
      @payload = {
          "url" => "http://jumpstartlab.com/blog",
          "requestedAt" => "2013-02-16 21:38:28 -0700",
          "respondedIn" => 27,
          "referredBy" => "http://jumpstartlab.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "socialLogin",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211" 
        }.to_json
        @delegate_return_value =   {
          "account_id" => 1,
          "http_request" => "get",
          "query_strings" => "[]",
          "url_id" => 1,
          "referrer_id" => 1,
          "event_id" => 1,
          "resolution_id" => 1,
          "ip_address_id" => 1,
          "browser_id" => 1,
          "operating_systems_id" => 1,
          "requested_at" => "2013-02-16 21:38:28 -0700",
          "hour_of_day" => 20,
          "responded_in" => 27
        }
    end

    describe ".parse" do
      it "exists" do
        expect {Payload.parse(@payload)}.to_not raise_exception
      end

      it "parses JSON data to a readable Ruby hash" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby)
        expect(payload).to be_a_kind_of(Payload)
      end
    end

    it "stores the parsed JSON into class instance variables" do
      parse_to_ruby = Payload.parse(@payload)
      payload = Payload.new(parse_to_ruby)
      expect(payload.url).to eq "http://jumpstartlab.com/blog"
    end

    it "checks to see if the payload passed in is new" do
      payload_instance.register(@delegate_return_value)
      puts DB[:payloads].select.to_a
      expect(Payload.new?(@payload)).to be_false
    end
  end
end