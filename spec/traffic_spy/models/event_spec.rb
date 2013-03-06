require 'spec_helper'

module TrafficSpy
  describe Event do

    before(:each) do
      Account.destroy_all
      Payload.destroy_all
      Event.destroy_all
      event.register
    end

    let (:event){ Event.new("antiSocialLogin") }

    it "exists" do
      Event.should be
    end

    it "tests whether a event already exists" do
      expect(Event.exists?("antiSocialLogin")).to be true
    end

    it "registers a new event in the events table" do
      expect(event.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(Event.get_id("antiSocialLogin")).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(Event.make_new_object("antiSocialLogin")).to be_kind_of(Integer)
    end

    it "makes a new object with a new event" do
      expect(Event.make_new_object("newEvent")).to be_kind_of(Integer)
    end
  end

  describe "it returns a breakdown of events for an identifier" do
    before(:each) do
      Account.destroy_all
      Payload.destroy_all
      Account.new("jean-luc", "http://picard.com").register
      payload = Payload.parse({
          "url" => "http://picard.com",
          "requestedAt" => "2013-02-16 21:38:26 -0700",
          "respondedIn" => 30,
          "referredBy" => "http://picard.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "socialLogin",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211" 
        }.to_json)
      Payload.new(payload, "jean-luc").register
    end

    let (:event){ Event.new("socialLogin") }

    it "returns a list of sorted events" do
      expect(Event.sorted_events("jean-luc")).to eq({"socialLogin"=>1})
    end

    it "returns a list of event registration times by hour" do
      expect(Event.registration_times("jean-luc", "socialLogin")).to eq({"09:00 pm"=>1})
    end
  end
end