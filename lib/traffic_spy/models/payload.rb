require 'json'

module TrafficSpy
  class Payload
    attr_reader :url,
                :requested_at,
                :responded_in,
                :referred_by,
                :request_type,
                :parameters,
                :event_name,
                :user_agent,
                :resolution_width,
                :resolution_height,
                :ip_address

    def initialize(input)
      @url = input["url"]
      @requested_at = input["requestedAt"]
      @responded_in = input["respondedIn"]
      @referred_by = input["referredBy"]
      @parameters = input["parameters"]
      @event_name = input["eventName"]
      @user_agent = input["userAgent"]
      @resolution_width = input["resolutionWidth"]
      @resolution_height = input["resolutionHeight"]
      @ip_address = input["ip"]
    end

    # def register
    #   DB[:payloads].insert(
    #     :url => @url,
    #     :requested_at => @requested_at,
    #     :responded_in => @responded_in,
    #     :referred_by => @referred_by,
    #     :parameters => @parameters,
    #     :event_name => @event_name,
    #     :user_agent => @user_agent,
    #     :resolution_width => @resolution_width,
    #     :resolution_height => @resolution_height,
    #     :ip_address => @ip_address)
    #   return true
    # end

    def self.parse(input)
      JSON.parse(input)
    end

    def self.new?(payload)
      DB[:payloads].where(:requested_at => payload["requestedAt"]).to_a.count < 1
    end

    def delegate
      # make new instances of the classes

      # receive key values as return from certain classes
        # account
        # url
        # referrer
        # event
        # resolution
        # ip
        # browser
        # os

      # return a hash of each table and corresponding value or row id
    end

    def register(hash_of_delegate)
      # with the hash, put an entry in the payload db table
      DB[:payloads].insert(
      :account_id => hash_of_delegate["account_id"],
      :http_request => hash_of_delegate["http_request"],
      :query_strings => hash_of_delegate["query_strings"],
      :url_id => hash_of_delegate["url_id"],
      :referrer_id => hash_of_delegate["referrer_id"],
      :event_id => hash_of_delegate["event_id"],
      :resolution_id => hash_of_delegate["resolution_id"],
      :ip_address_id => hash_of_delegate["ip_address_id"],
      :browser_id => hash_of_delegate["browser_id"],
      :operating_systems_id => hash_of_delegate["operating_systems_id"],
      :requested_at => hash_of_delegate["requested_at"],
      :hour_of_day => hash_of_delegate["hour_of_day"],
      :responded_in => hash_of_delegate["responded_in"])
      return true
    end
  end
end