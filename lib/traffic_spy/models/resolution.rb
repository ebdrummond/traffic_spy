module TrafficSpy
  class Resolution
    attr_reader :resolution

    def initialize(input)
      @resolution = input
    end

    def self.exists?(resolution)
      DB[:resolutions].where(:resolution => resolution).to_a.count > 0
    end

    def self.combine_resolutions(width, height)
      "#{width} x #{height}"
    end

    def self.get_id(resolution)
      resolution_row = DB[:resolutions].where(:resolution => resolution).to_a
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
      DB[:resolutions].insert(:resolution => @resolution)
      return true
    end
  end
end