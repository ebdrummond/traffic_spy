require 'spec_helper'

module TrafficSpy
  describe Resolution do
    it "exists" do
      Resolution.should be
    end

    it "should take in Resolution string" do
      instance = Resolution.new("1080x720")
      expect(instance.resolution).to eq "1080x720"
    end
  end
end