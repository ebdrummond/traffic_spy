require 'spec_helper'

module TrafficSpy
  describe Url do
    it "exists" do
      Url.should be
    end

    it "should take in URL string" do
      instance = Url.new("http://jumpstartlab.com/blog")
      expect(instance.url).to eq "http://jumpstartlab.com/blog"
    end
  end
end