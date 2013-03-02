require 'spec_helper'

module TrafficSpy
  describe ReferringUrl do
    before(:each) do
      @referring_url = "http://jumpstartlab.com"
      @referring_url_instance = ReferringUrl.new(@referring_url)
      @referring_url_instance.register
    end

    it "exists" do
      ReferringUrl.should be
    end

    it "should take in URL string" do
      instance = ReferringUrl.new("http://jumpstartlab.com")
      expect(instance.referring_url).to eq "http://jumpstartlab.com"
    end

    it "tests whether a referring URL already exists" do
      expect(ReferringUrl.exists?(@referring_url)).to be true
    end

    it "registers a new referring Url in the URLs table" do
      expect(@referring_url_instance.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(ReferringUrl.get_id(@referring_url)).to eq 1
    end
  end
end