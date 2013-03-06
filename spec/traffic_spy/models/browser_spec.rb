require 'spec_helper'

module TrafficSpy
  describe Browser do
    before(:each) do
      Account.destroy_all
      Payload.destroy_all
      Browser.destroy_all
      browser.register
    end

    let (:browser){ Browser.new("Chrome") }

    it "exists" do
      Browser.should be
    end

    it "tests whether a browser already exists" do
      expect(Browser.exists?("Chrome")).to be true
    end

    it "registers a new browser in the browsers table" do
      expect(browser.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(Browser.get_id("Chrome")).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(Browser.make_new_object("Chrome")).to be_kind_of(Integer)
    end

    it "makes a new object with a new browser" do
      expect(Browser.make_new_object("Firefox")).to be_kind_of(Integer)
    end
  end

  describe "it returns a breakdown of browsers for an identifier" do
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
            " Safari/537.17",
            "resolutionWidth" => "1920",
            "resolutionHeight" => "1280",
            "ip" => "63.29.38.211"
          }.to_json)
        Payload.new(payload, "jean-luc").register
      end

    let (:browser){ Browser.new("Chrome") }

    it "returns browser breakdown across requests" do
      browser.register
      expect(Browser.breakdown("jean-luc")).to eq({"Chrome"=>1})
    end
  end
end