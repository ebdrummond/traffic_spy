require 'spec_helper'

module TrafficSpy
  describe Event do

    before(:each) do
      @event = "socialLogin"
      @event_instance = Event.new(@event)
      @event_instance.register
    end

    it "exists" do
      Event.should be
    end

    it "should take in Event string" do
      instance = Event.new("Zombie Run")
      expect(instance.event).to eq "Zombie Run"
    end

    it "tests whether a event already exists" do
      expect(Event.exists?(@event)).to be true
    end

    it "should take in event string" do
      instance = Event.new("socialLogin")
      expect(instance.event).to eq "socialLogin"
    end

    it "registers a new event in the events table" do
      expect(@event_instance.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(Event.get_id(@event)).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(Event.make_new_object(@event)).to be_kind_of(Integer)
    end

    it "makes a new object with a new event" do
      expect(Event.make_new_object("newEvent")).to be_kind_of(Integer)
    end

    it "returns a list of sorted events" do
      expect(Event.sorted_events("erin")).to be_kind_of(Hash)
    end
  end
end