module TrafficSpy
  class CampaignEvent

    def initialize(campaign_id, event_id)
      @campaign_id = campaign_id
      @event_id = event_id
    end

    def register(identifier)
      account_id = Account.get_id(identifier)
      DB[:campaign_events].insert(
        :account_id => account_id,
        :campaign_id => @campaign_id,
        :event_id => @event_id)
      return true
    end

    # def self.campaign_event_count(identifier)
    #   campaigns = DB[:campaigns]
    #   events = DB[:events]
    #   campaign_events = DB[:campaign_events]
    #   account_id = Account.get_id(identifier)

    #   url_id_query = DB[:urls].where(:url => url_path).to_a
    #   url_id = url_id_query[0][:id]

    #   response_by_date = Hash.new{0}
    #   payloads_for_url = payloads.where(:account_id => account_id).where(:url_id => url_id).order(Sequel.desc(:responded_in))
    #   payloads_for_url.to_a.each do |payload_row|
    #     response_by_date[payload_row[:requested_at]] = payload_row[:responded_in]
    #   end
    #   response_by_date
    # end

    def self.get_id(identifier)
      campaign_events_row = DB[:campaign_events].where(:campaign_id => campaign_id).where(:event_id => event_id).to_a
      campaign_event_ids = campaign_events_row[0][:id]
    end
  end
end