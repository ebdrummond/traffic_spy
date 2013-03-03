require 'json'
require 'agent_orange'

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
                :resolution,
                :ip_address,
                :browser,
                :operating_system

    def initialize(payload, identifier)
      @url = payload["url"]
      @requested_at = payload["requestedAt"]
      @responded_in = payload["respondedIn"]
      @referred_by = payload["referredBy"]
      @request_type = payload["requestType"]
      @parameters = payload["parameters"]
      @event_name = payload["eventName"]
      @user_agent = payload["userAgent"]
      @resolution_width = payload["resolutionWidth"]
      @resolution_height = payload["resolutionHeight"]
      @ip_address = payload["ip"]
      @identifier = identifier
    end

    def self.parse(input)
      JSON.parse(input)
    end

    def self.new?(payload)
      DB[:payloads].where(:requested_at => payload["requestedAt"]).to_a.count < 1
    end

    def delegate
      parse_payload_further
      payload_db_row = {
      "account_id" => generate_account_id,
      "http_request" => @request_type,
      "query_strings" => @parameters,
      "url_id" => generate_url_id,
      "referrer_id" => generate_referring_url_id,
      "event_id" => generate_event_id,
      "resolution_id" => generate_resolution_id,
      "ip_address_id" => generate_ip_address_id,
      "browser_id" => generate_browser_id,
      "operating_system_id" => generate_operating_system_id,
      "requested_at" => @requested_at,
      "hour_of_day" => @hour_of_day,
      "responded_in" => @responded_in
      }
    end

    def parse_payload_further
      @resolution = Resolution.combine_resolutions(@resolution_width, @resolution_height)
      user_agent = AgentOrange::UserAgent.new(@user_agent)
      @browser = user_agent.device.engine.browser
      @operating_system = user_agent.device.operating_system.name
      @hour_of_day = get_hour_of_day
    end

    def get_hour_of_day
      requested_parts = @requested_at.split(" ")
      requested_parts[1][0..1]
    end

    def generate_account_id
      Account.make_new_object(@identifier)
    end

    def generate_url_id
      Url.make_new_object(@url)
    end

    def generate_event_id
      Event.make_new_object(@event)
    end

    def generate_referring_url_id
      ReferringUrl.make_new_object(@referring_url)
    end

    def generate_ip_address_id
      IpAddress.make_new_object(@ip_address)
    end

    def generate_resolution_id
      Resolution.make_new_object(@resolution)
    end

    def generate_browser_id
      Browser.make_new_object(@browser)
    end

    def generate_operating_system_id
      OperatingSystem.make_new_object(@operating_system)
    end

    def register(hash_of_delegate)
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
      :operating_system_id => hash_of_delegate["operating_system_id"],
      :requested_at => hash_of_delegate["requested_at"],
      :hour_of_day => hash_of_delegate["hour_of_day"],
      :responded_in => hash_of_delegate["responded_in"])
      return true
    end
  end
end