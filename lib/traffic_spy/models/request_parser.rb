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

    def self.parse(input)
      request_hash = parse_json(input)
      @url = request_hash["url"]
      @requested_at = request_hash["requested_at"]
      @responded_in = request_hash["responded_in"]
      @referred_by = request_hash["referred_by"]
      @request_type = request_hash["request_type"]
      @parameters = request_hash["parameters"]
      @event_name = request_hash["event_name"]
      @user_agent = request_hash["user_agent"]
      @resolution_width = request_hash["resolution_width"]
      @resolution_height = request_hash["resolution_height"]
      @ip_address = request_hash["ip_address"]
    end

    def self.parse_json(input)
      JSON.parse(input)
    end
  end
end

