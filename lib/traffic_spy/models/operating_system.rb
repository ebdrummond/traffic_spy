module TrafficSpy
  class OperatingSystem
    attr_reader :operating_system
    
    def initialize(input)
      @operating_system = input
    end

    def self.operating_systems
      DB[:operating_systems]
    end

    def self.exists?(operating_system)
      operating_systems.where(:operating_system => operating_system).to_a.count > 0
    end

    def self.get_id(operating_system)
      operating_system_row = operating_systems.where(:operating_system => operating_system).to_a
      operating_system_id = operating_system_row[0][:id]
    end

    def self.destroy_all
      operating_systems.delete
    end

    def self.make_new_object(operating_system)
      if exists?(operating_system)
        get_id(operating_system)
      else
        operating_system_instance = OperatingSystem.new(operating_system)
        operating_system_instance.register
        get_id(operating_system)
      end
    end

    def register
      OperatingSystem.operating_systems.insert(:operating_system => @operating_system)
      return true
    end

    def self.breakdown(identifier)
      payloads = DB[:payloads]
      account_id = Account.get_id(identifier)

      os_hash = Hash.new(0)
      os_by_account_id = payloads.where(:account_id => account_id).join(:operating_systems, :id => :operating_system_id).group_and_count(:operating_system_id).order(Sequel.desc(:count)).exclude(:operating_system => "")
      os_by_account_id.to_a.each do |os_row|
        os_id = os_row[:operating_system_id]
        actual_os_query = operating_systems.where(:id => os_id).to_a
        actual_os = actual_os_query[0][:operating_system]
        os_hash[actual_os] += os_row[:count]
      end
      os_hash
    end
  end
end