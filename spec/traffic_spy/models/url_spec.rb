require 'spec_helper'

module TrafficSpy
  describe Url do
    before(:each) do
      @url = "http://jumpstartlab.com"
    end

    it "exists" do
      Url.should be
    end

    it "should take in URL string" do
      instance = Url.new("http://jumpstartlab.com/blog")
      expect(instance.url).to eq "http://jumpstartlab.com/blog"
    end

    it "registers a new Url in the URLs table" do
      url = Url.new(@url)
      expect(url.register).to eq true
    end

    it "returns the id of the row in the table" do
      url = Url.new(@url)
      url.register
      expect(Url.get_id(@url)).to eq 1
    end
  end
end