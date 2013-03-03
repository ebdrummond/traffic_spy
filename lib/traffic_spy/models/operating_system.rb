module TrafficSpy
  class OperatingSystem
    attr_reader :operating_system
    
    def initialize(input)
      @operating_system = input
    end

    def self.exists?(operating_system)
      DB[:operating_systems].where(:operating_system => operating_system).to_a.count > 0
    end

    def self.get_id(operating_system)
      operating_system_row = DB[:operating_systems].where(:operating_system => operating_system).to_a
      operating_system_id = operating_system_row[0][:id]
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
      DB[:operating_systems].insert(:operating_system => @operating_system)
      return true
    end
  end
end