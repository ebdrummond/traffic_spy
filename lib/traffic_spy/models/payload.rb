require 'json'
require 'agent_orange'

module TrafficSpy
  class Payload
    attr_reader :url,
                :path,
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
      @url = Url.get_path(payload["url"])
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

    def self.payloads
      DB[:payloads]
    end

    def self.new?(payload)
      payloads.where(:requested_at => payload["requestedAt"]).to_a.count < 1
    end

    def self.params_missing?(payload)
      payload.any?{|payload_param| if payload_param[0] != "eventName" then (payload_param[1] == "" || payload_param[1] == nil) end}
    end

    def parse_payload_further
      @resolution = Resolution.combine_resolutions(@resolution_width, @resolution_height)
      user_agent = AgentOrange::UserAgent.new(@user_agent)
      @browser = user_agent.device.engine.browser.name
      @operating_system = user_agent.device.operating_system.name
    end

    def self.destroy_all
      payloads.delete
    end

    def generate_account_id
      Account.get_id(@identifier)
    end

    def generate_url_id
      Url.make_new_object(@url)
    end

    def generate_event_id
      Event.make_new_object(@event_name)
    end

    def generate_referring_url_id
      ReferringUrl.make_new_object(@referred_by)
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

    def self.destroy_all
      DB[:payloads].delete
    end

    def register
      parse_payload_further

      DB[:payloads].insert(
      :account_id => generate_account_id,
      :http_request => @http_request,
      :query_strings => @query_strings,
      :url_id => generate_url_id,
      :referrer_id => generate_referring_url_id,
      :event_id => generate_event_id,
      :resolution_id => generate_resolution_id,
      :ip_address_id => generate_ip_address_id,
      :browser_id => generate_browser_id,
      :operating_system_id => generate_operating_system_id,
      :requested_at => @requested_at,
      :responded_in => @responded_in)
      return true
    end
  end
end