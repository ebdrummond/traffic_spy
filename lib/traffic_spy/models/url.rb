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

    def self.get_path(full_url)
      parts = full_url.split("/")
      if parts[3]
        path = "/" + parts[3..-1].join("/")
      else
        path = "/"
      end
      path
    end

    def self.sorted_urls(identifier)
      urls = DB[:urls]
      payloads = DB[:payloads]
      account_id = Account.get_id(identifier)

      url_sorted_hash = Hash.new{0}
      url_ids_by_count = payloads.where(:account_id => account_id).join(:urls, :id => :url_id).group_and_count(:url_id).order(Sequel.desc(:count))
      url_ids_by_count.to_a.each do |url_row|
        url_id = url_row[:url_id]
        actual_url_query = DB[:urls].where(:id => url_id).to_a
        actual_url = actual_url_query[0][:url]
        url_sorted_hash[actual_url] += url_row[:count]
      end
      url_sorted_hash
    end

    def self.response_times(identifier, url_path)
      payloads = DB[:payloads]
      urls = DB[:urls]
      account_id = Account.get_id(identifier)

      url_id_query = DB[:urls].where(:url => url_path).to_a
      url_id = url_id_query[0][:id]

      response_by_date = Hash.new{0}
      payloads_for_url = payloads.where(:account_id => account_id).where(:url_id => url_id).order(Sequel.desc(:responded_in))
      payloads_for_url.to_a.each do |payload_row|
        date = 
        response_by_date[payload_row[:requested_at]] = payload_row[:responded_in]
      end
      response_by_date
    end

    def self.average_response_times(identifier)
      payloads = DB[:payloads]
      urls = DB[:urls]
      account_id = Account.get_id(identifier)

      times_sorted_hash = Hash.new{0}
      payloads_for_url = payloads.where(:account_id => account_id).order(Sequel.desc(:responded_in))
      payloads_for_url.to_a.each do |payload_row|
        date = 
        times_sorted_hash[payload_row[:requested_at]] = payload_row[:responded_in]
      end
      times_sorted_hash
    end
  end
end