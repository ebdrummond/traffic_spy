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
      url_id = url_row[0][:id]
    end

    def self.make_new_object(url)
      if exists?(url)
        get_id(url)
      else
        url_instance = Url.new(url)
        url_instance.register
        get_id(url)
      end
    end

    def register
      DB[:urls].insert(:url => @url)
      return true
    end

    def self.all_urls(identifier)
      urls = DB[:urls]
      payloads = DB[:payloads]
      accounts = DB[:accounts]

      something = Hash.new{0}
      url_ids_by_count = payloads.join(:urls, :id => :url_id).group_and_count(:url_id)
      url_ids_by_count.each do |url|
        url_id = url[:url_id]
        actual_url_query = DB[:urls].where(:id => url_id)
        actual_url = actual_url_query[:url].to_a
        something[url] += url[:count]
      end      
    end

    def self.url_sort

    end
  end
end