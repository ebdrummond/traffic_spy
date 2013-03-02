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

    def register
      DB[:payloads].insert(
        :url => @url,
        :requested_at => @requested_at,
        :responded_in => @responded_in,
        :referred_by => @referred_by,
        :parameters => @parameters,
        :event_name => @event_name,
        :user_agent => @user_agent,
        :resolution_width => @resolution_width,
        :resolution_height => @resolution_height,
        :ip_address => @ip_address)
      return true
    end

    def self.parse(input)
      JSON.parse(input)
    end
  end
end