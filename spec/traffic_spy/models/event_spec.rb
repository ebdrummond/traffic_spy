require 'spec_helper'

module TrafficSpy
  describe Event do
    it "exists" do
      Event.should be
    end

    it "should take in Event string" do
      instance = Event.new("Zombie Run")
      expect(instance.event).to eq "Zombie Run"
    end
  end
end