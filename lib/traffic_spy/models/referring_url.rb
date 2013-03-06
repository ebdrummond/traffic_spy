module TrafficSpy
  class ReferringUrl
    attr_reader :referring_url

    def initialize(input)
      @referring_url = input
    end

    def self.destroy_all
      referring_urls.delete
    end

    def self.referring_urls
      DB[:referring_urls]
    end

    def self.exists?(referring_url)
      referring_urls.where(:referring_url => referring_url).count > 0
    end

    def self.get_id(referring_url)
      referring_url_row = referring_urls.
      where(:referring_url => referring_url).to_a

      referring_url_id = referring_url_row[0][:id]
    end

    def self.make_new_object(referring_url)
      if exists?(referring_url)
        get_id(referring_url)
      else
        referring_url_instance = ReferringUrl.new(referring_url)
        referring_url_instance.register
        get_id(referring_url)
      end
    end

    def register
      ReferringUrl.referring_urls.insert(:referring_url => referring_url)
      return true
    end
  end
end