module TrafficSpy
  class Url
    attr_reader :url

    def initialize(input)
      @url = input
    end

    def self.exists?(url)
      DB[:urls].where(:url => url).to_a.count > 0
    end

    def self.get_id(url)
      url_row = DB[:urls].where(:url => url).to_a
      puts url_row
      url_id = url_row[0][:id]
    end

    def register
      DB[:urls].insert(:url => @url)
      return true
    end
  end
end