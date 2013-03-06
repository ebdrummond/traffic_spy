require 'spec_helper'

module TrafficSpy
  describe OperatingSystem do
    before(:each) do
      Account.destroy_all
      Payload.destroy_all
      OperatingSystem.destroy_all
      operating_system.register
    end

    let (:operating_system){ OperatingSystem.new("Mac OS X") }

    it "exists" do
      OperatingSystem.should be
    end

    it "tests whether an operating_system already exists" do
      expect(OperatingSystem.exists?("Mac OS X")).to be true
    end

    it "registers a new operating_system in the operating systems table" do
      expect(OperatingSystem.new("Windows").register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(OperatingSystem.get_id("Mac OS X")).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(OperatingSystem.make_new_object("Mac OS X")).to be_kind_of(Integer)
    end

    it "makes a new object with a new operating_system" do
      expect(OperatingSystem.make_new_object("Linux")).to be_kind_of(Integer)
    end
  end

  describe "it returns a breakdown of operating systems for an identifier" do
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

    let (:operating_system){ OperatingSystem.new("Mac OS X") }

    it "returns operating systems breakdown" do
      operating_system.register
      expect(OperatingSystem.breakdown("jean-luc")).to eq({"Mac OS X"=>1})
    end
  end
end