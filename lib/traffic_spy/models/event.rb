module TrafficSpy
  class Event
    attr_reader :event

    def initialize(input)
      @event = input
    end
  end
end