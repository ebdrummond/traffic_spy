module TrafficSpy
  class Event
    attr_reader :event

    def initialize(input)
      @event = input
    end

    def self.exists?(event)
      DB[:events].where(:event => event).to_a.count > 0
    end

    def self.get_id(event)
      event_row = DB[:events].where(:event => event).to_a
      event_id = event_row[0][:id]
    end

    def self.make_new_object(event)
      if exists?(event)
        get_id(event)
      else
        event_instance = Event.new(event)
        event_instance.register
        get_id(event)
      end
    end

    def register
      DB[:events].insert(:event => @event)
      return true
    end
  end
end