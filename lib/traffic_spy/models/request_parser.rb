require 'json'

module TrafficSpy
  class RequestParser

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

    def self.parse_json(input)
      JSON.parse(input)
    end

    def initialize(input)
      @url = input["url"]
    end

  end
end

