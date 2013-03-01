require 'spec_helper'

module TrafficSpy
  describe OperatingSystem do
    it "exists" do
      OperatingSystem.should be
    end

    it "should take in URL string" do
      instance = OperatingSystem.new("Mac OS X 10_8_2")
      expect(instance.operating_system).to eq "Mac OS X 10_8_2"
    end
  end
end