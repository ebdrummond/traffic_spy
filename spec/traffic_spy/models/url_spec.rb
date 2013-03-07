require 'spec_helper'

module TrafficSpy
  describe Url do
    before(:each) do
      Url.destroy_all
      url.register
    end

    let (:url){ Url.new("http://kirk.com") }

    it "exists" do
      Url.should be
    end

    it "tests whether a URL already exists" do
      expect(Url.exists?("http://kirk.com")).to be true
    end

    it "registers a new Url in the URLs table" do
      expect(url.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(Url.get_id("http://kirk.com")).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(Url.make_new_object("http://kirk.com")).to be_kind_of(Integer)
    end

    it "makes a new object with a new url" do
      expect(Url.make_new_object("http://newurl.com")).to be_kind_of(Integer)
    end
  end

  describe "returns a urls breakdown" do
    before(:each) do
      Account.new("james", "http://kirk.com").register
      payload = Payload.parse({
          "url" => "http://kirk.com",
          "requestedAt" => "2013-02-16 21:38:26 -0700",
          "respondedIn" => 30,
          "referredBy" => "http://kirk.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "socialLogin",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)" +
            " AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0" +
            " Safari/537.17",          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211"
        }.to_json)
      Payload.new(payload, "james").register
    end

    let (:url){ Url.new("http://kirk.com") }

    it "returns urls sorted by top visited urls" do
      url.register
      expect(Url.sorted_urls("james")).to be_kind_of(Hash)
    end

    it "returns a list of response times by URL" do
      url.register
      expect(Url.response_times("james", "/")).to be_kind_of(Hash)
    end

    it "returns a list of average response times by identifier" do
      url.register
      expect(Url.average_response_times("james")).to be_kind_of(Hash)
    end
  end
end