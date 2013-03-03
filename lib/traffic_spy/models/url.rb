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
      # DB[:urls].join(:url, )
      # DB[:urls].select
      # Get the account ID number for below

      # Gives us an array of the payload mixed w/ url for a specific account
      our_join = urls.join(:payloads, :url_id => :id)
      our_join.to_a
      our_join.where(:account_id => 1)
      new_join = our_join.where(:account_id => 1)
      new_join.to_a
      # sort the current array or query by quantity of appearances of an url id
      new_join.order(:)
    end

    def self.url_sort

    end
  end
end