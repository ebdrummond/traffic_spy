module TrafficSpy
  class Account

    attr_reader :identifier

    def initialize(identifier, root_url)
      @identifier = identifier
      @root_url = root_url
    end

    def self.exists?(identifier)
      DB[:accounts].where(:identifier => identifier).to_a.count > 0
    end

    def register
      DB[:accounts].insert(
        :identifier => @identifier,
        :root_url => @root_url)
      return true
    end
  end
end