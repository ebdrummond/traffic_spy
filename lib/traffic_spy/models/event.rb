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

    def self.sorted_events(identifier)
      events = DB[:events]
      payloads = DB[:payloads]
      account_id = Account.get_id(identifier)

      event_sorted_hash = Hash.new(0)
      event_ids_by_count = payloads.where(:account_id => account_id).join(:events, :id => :event_id).group_and_count(:event_id).order(Sequel.desc(:count))
      event_ids_by_count.to_a.each do |event_row|
        event_id = event_row[:event_id]
        actual_event_query = DB[:events].where(:id => event_id).to_a
        actual_event = actual_event_query[0][:event]
        event_sorted_hash[actual_event] += event_row[:count]
        puts event_sorted_hash
      end
      event_sorted_hash
    end
  end
end