module TrafficSpy
  class IpAddress
    attr_reader :ip_address
    
    def initialize(input)
      @ip_address = input
    end

    def self.exists?(ip_address)
      DB[:ip_addresses].where(:ip_address => ip_address).to_a.count > 0
    end

    def self.get_id(ip_address)
      ip_address_row = DB[:ip_addresses].where(:ip_address => ip_address).to_a
      ip_address_id = ip_address_row[0][:id]
    end

    def self.make_new_object(ip_address)
      if exists?(ip_address)
        get_id(ip_address)
      else
        ip_address_instance = IpAddress.new(ip_address)
        ip_address_instance.register
        get_id(ip_address)
      end
    end

    def register
      DB[:ip_addresses].insert(:ip_address => @ip_address)
      return true
    end
  end
end