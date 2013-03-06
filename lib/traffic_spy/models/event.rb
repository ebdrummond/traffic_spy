require 'time'
require 'date'

module TrafficSpy
  class Event
    attr_reader :event, :reg_hours

    def initialize(input)
      @event = input
    end

    def self.destroy_all
      events.delete
    end

    def self.events
      DB[:events]
    end

    def self.exists?(event)
      events.where(:event => event).to_a.count > 0
    end

    def self.get_id(event)
      event_row = events.where(:event => event).to_a
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

    def self.destroy_all
      DB[:events].delete
    end

    def register
      Event.events.insert(:event => @event)
      return true
    end

    def self.sorted_events(identifier)
      payloads = DB[:payloads]
      account_id = Account.get_id(identifier)

      event_sorted_hash = Hash.new(0)
      event_ids_by_count = payloads.where(:account_id => account_id).join(:events, :id => :event_id).group_and_count(:event_id).order(Sequel.desc(:count))
      event_ids_by_count.to_a.each do |event_row|
        event_id = event_row[:event_id]
        actual_event_query = events.where(:id => event_id).to_a
        actual_event = actual_event_query[0][:event]
        event_sorted_hash[actual_event] += event_row[:count]
      end
      event_sorted_hash
    end

    def self.destroy_all
      DB[:events].delete
    end

    def self.registration_times(identifier, event_name)
      payloads = DB[:payloads]
      account_id = Account.get_id(identifier)
      event_id = get_id(event_name)

      event_reg_time_hash = Hash.new(0)
      event_reg_hours_by_count = payloads.where(:account_id => account_id).where(:event_id => event_id).group_and_count(:requested_at)
      
      event_reg_hours_by_count.each do |payload_row|
        requested_at = payload_row[:requested_at]
        reg_hours = requested_at.strftime("%I:00 %P")
        event_reg_time_hash[reg_hours] += payload_row[:count]
      end
      event_reg_time_hash.sort_by{|key, value| -value }
    end
  end
end