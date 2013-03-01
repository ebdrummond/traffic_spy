require 'spec_helper'

module TrafficSpy
  describe Browser do
    it "exists" do
      Browser.should be
    end

    it "should take in Browser string" do
      instance = Browser.new("Chrome")
      expect(instance.browser).to eq "Chrome"
    end
  end
end