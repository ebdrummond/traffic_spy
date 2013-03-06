module TrafficSpy
  class Resolution
    attr_reader :resolution

    def initialize(input)
      @resolution = input
    end

    def self.resolutions
      DB[:resolutions]
    end

    def self.destroy_all
      resolutions.delete
    end

    def self.exists?(resolution)
      resolutions.where(:resolution => resolution).to_a.count > 0
    end

    def self.combine_resolutions(width, height)
      "#{width} x #{height}"
    end

    def self.get_id(resolution)
      resolution_row = resolutions.where(:resolution => resolution).to_a
      resolution_id = resolution_row[0][:id]
    end

    def self.make_new_object(resolution)
      if exists?(resolution)
        get_id(resolution)
      else
        resolution_instance = Resolution.new(resolution)
        resolution_instance.register
        get_id(resolution)
      end
    end

    def register
      Resolution.resolutions.insert(:resolution => @resolution)
      return true
    end

    def self.breakdown(identifier)
      payloads = DB[:payloads]
      account_id = Account.get_id(identifier)

      resolution_hash = Hash.new(0)
      resolution_by_account_id = payloads.where(:account_id => account_id).
      join(:resolutions, :id => :resolution_id).
      group_and_count(:resolution_id).order(Sequel.desc(:count))

      resolution_by_account_id.to_a.each do |resolution_row|
        resolution_id = resolution_row[:resolution_id]
        actual_resolution_query = resolutions.where(:id => resolution_id).to_a
        actual_resolution = actual_resolution_query[0][:resolution]
        resolution_hash[actual_resolution] += resolution_row[:count]
      end
      resolution_hash
    end
  end
end