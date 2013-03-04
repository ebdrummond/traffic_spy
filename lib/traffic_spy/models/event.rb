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
      end
      event_sorted_hash
    end

    def self.get_id(event)
      event_row = DB[:events].where(:event => event).to_a
      event_id = event_row[0][:id]
    end

    # def self.get_hour_of_day
    #   requested_at = DB[:payloads].where(:requested_at => requested_at)
    #   requested_parts = requested_at.split(" ")
    #   requested_parts[1][0..1]
    # end

    def self.registration_times(identifier, event_name)
      events = DB[:events]
      payloads = DB[:payloads]
      account_id = Account.get_id(identifier)
      event_id = get_id(event_name)

      event_reg_time_hash = Hash.new(0)
      event_reg_hours_by_count = payloads.where(:account_id => account_id).where(:event_id => event_id).group_and_count(:requested_at)
      
      event_reg_hours_by_count.each do |payload_row|
        requested_at = payload_row[:requested_at].to_s
        requested_parts = requested_at.split(" ")
        reg_hours = requested_parts[1][0..1]
      end
      #have - array of hashes showing requested at and count of requests
      #[{:requested_at=>1915-07-02 05:17:28 -0700, :count=>1}, {:requested_at=>1915-08-02 05:17:28 -0700, :count=>1}] 
      #need - hours of event registration and count
      puts event_reg_hours_by_count
    end
  end
end