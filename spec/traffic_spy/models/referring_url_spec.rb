require 'spec_helper'

module TrafficSpy
  describe ReferringUrl do
    it "exists" do
      ReferringUrl.should be
    end

    it "should take in URL string" do
      instance = ReferringUrl.new("http://jumpstartlab.com")
      expect(instance.referring_url).to eq "http://jumpstartlab.com"
    end
  end
end