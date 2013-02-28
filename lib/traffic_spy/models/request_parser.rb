require 'json'

module TrafficSpy
  module RequestParser

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

    def self.parse(input)
      request_hash = parse_json(input)
      @url = request_hash["url"]
    end

    def self.parse_json(input)
      JSON.parse(input)
    end
  end
end

