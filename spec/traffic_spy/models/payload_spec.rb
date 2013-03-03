require 'spec_helper'

module TrafficSpy
  describe Payload do
    it "exists" do
      Payload.should be
    end

    let (:payload_instance) { Payload.new(@payload, "jumpstartlab") }
    before(:each) do
      @payload = {
          "url" => "http://jumpstartlab.com",
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

      # @delegate_return_value = {
      #   "account_id" => 1,
      #   "http_request" => "get",
      #   "query_strings" => "[]",
      #   "url_id" => 1,
      #   "referrer_id" => 1,
      #   "event_id" => 1,
      #   "resolution_id" => 1,
      #   "ip_address_id" => 1,
      #   "browser_id" => 1,
      #   "operating_systems_id" => 1,
      #   "requested_at" => "2013-02-16 21:38:26 -0700",
      #   "hour_of_day" => "21",
      #   "responded_in" => 30
      #   }
    end

    describe ".parse" do
      it "exists" do
        expect {Payload.parse(@payload)}.to_not raise_exception
      end

      it "parses JSON data to a readable Ruby hash" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload).to be_a_kind_of(Payload)
      end

      it "stores the parsed JSON into class instance variables" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.url).to eq "http://jumpstartlab.com"
      end

      it "checks to see if the payload passed in is new" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        payload.register
        expect(Payload.new?(parse_to_ruby)).to be_false
      end

      it "generates the hour of the day a request was made" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.get_hour_of_day).to eq "21"
      end

      it "parses the 'problem' objects in the payload" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.parse_payload_further).to eq "21"
      end

      it "creates a new account object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.generate_account_id).to be_kind_of(Integer)
      end

      it "creates a new URL object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.generate_url_id).to be_kind_of(Integer)
      end

      it "creates a new event object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.generate_event_id).to be_kind_of(Integer)
      end

      it "creates a new referring url object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.generate_referring_url_id).to be_kind_of(Integer)
      end

      it "creates a new ip address object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.generate_ip_address_id).to be_kind_of(Integer)
      end

      it "creates a new resolution object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.generate_resolution_id).to be_kind_of(Integer)
      end

      it "creates a new browser object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.generate_browser_id).to be_kind_of(Integer)
      end

      it "creates a new operating system object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.generate_operating_system_id).to be_kind_of(Integer)
      end

      it "creates a payload object" do
        parse_to_ruby = Payload.parse(@payload)
        payload = Payload.new(parse_to_ruby, "jumpstartlab")
        expect(payload.register).to be true
      end
    end
  end
end