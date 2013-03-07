require 'spec_helper'

module TrafficSpy
  describe Resolution do
    before(:each) do
      Account.destroy_all
      Payload.destroy_all
      Resolution.destroy_all
      resolution.register
    end

    let (:resolution){ Resolution.new("1920 x 1280") }

    it "exists" do
      Resolution.should be
    end

    it "should take in Resolution string" do
      instance = Resolution.new("1080x720")
      expect(instance.resolution).to eq "1080x720"
    end

    it "tests whether a resolution already exists" do
      expect(Resolution.exists?("1920 x 1280")).to be true
    end

    it "combines resolution width and height" do
      expect(Resolution.combine_resolutions("1440", "900")).to eq "1440 x 900"
    end

    it "registers a new resolution in the resolutions table" do
      expect(Resolution.new("1020 x 800").register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(Resolution.get_id("1920 x 1280")).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(Resolution.make_new_object("1920 x 1280")).to be_kind_of(Integer)
    end

    it "makes a new object with a new resolution" do
      expect(Resolution.make_new_object("1280 x 800")).to be_kind_of(Integer)
    end
  end

  describe "returns a resolutions breakdown" do
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
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)" +
            " AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0" +
            " Safari/537.17",          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211"
        }.to_json)
      Payload.new(payload, "jean-luc").register
    end

    let (:resolution){ Resolution.new("1920 x 1280") }

    it "returns a breakdown of screen resolutions across all requests" do
      resolution.register
      expect(Resolution.breakdown("jean-luc")).to eq({"1920 x 1280"=>1})
    end
  end
end