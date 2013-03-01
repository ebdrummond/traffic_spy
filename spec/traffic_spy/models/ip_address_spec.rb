require 'spec_helper'

module TrafficSpy
  describe IpAddress do
    it "exists" do
      IpAddress.should be
    end

    it "should take in URL string" do
      instance = IpAddress.new("63.29.38.211")
      expect(instance.ip_address).to eq "63.29.38.211"
    end
  end
end