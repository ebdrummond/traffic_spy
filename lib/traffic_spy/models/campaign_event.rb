module TrafficSpy
  class CampaignEvent

    def initialize(identifier, campaign_id, event_id)
      @identifier = identifier
      @campaign_id = campaign_id
      @event_id = event_id
    end

    def self.any?(identifier)
      account_id = Account.get_id(identifier)
      DB[:campaign_events].where(:account_id => account_id).to_a.count > 0
    end

    def register
      account_id = Account.get_id(@identifier)
      DB[:campaign_events].insert(
        :account_id => account_id,
        :campaign_id => @campaign_id,
        :event_id => @event_id)
      return true
    end

    def self.campaign_event_count(identifier)
      campaigns = DB[:campaigns]
      events = DB[:events]
      campaign_events = DB[:campaign_events]
      account_id = Account.get_id(identifier)

      campaign_event_count = Hash.new{0}
      campaigns_for_account = campaign_events.where(:account_id => account_id).group_and_count(:campaign_id).order(Sequel.desc(:count))
      campaigns_for_account.to_a.each do |campaign_event_row|
        campaign_id = campaign_event_row[:campaign_id]
        actual_campaign_query = DB[:campaigns].where(:id => campaign_id).to_a
        actual_campaign = actual_campaign_query[0][:campaign]
        campaign_event_count[actual_campaign] = campaign_event_row[:count]
      end
      campaign_event_count
    end

    def self.campaign_events(identifier, campaign)
      campaigns = DB[:campaigns]
      events = DB[:events]
      campaign_events = DB[:campaign_events]
      account_id = Account.get_id(identifier)
      campaign_id = Campaign.get_id(campaign)

      campaign_events_list = Array.new{0}
      events_for_campaign = campaign_events.where(:account_id => account_id).where(:campaign_id => campaign_id).order(Sequel.asc(:id))
      events_for_campaign.to_a.each do |event_for_campaign|
        event_id = event_for_campaign[:event_id]
        actual_event_query = DB[:events].where(:id => event_id).to_a
        actual_event = actual_event_query[0][:event]
        campaign_events_list << actual_event
      end
      campaign_events_list
    end

    def self.get_id(identifier)
      campaign_events_row = DB[:campaign_events].where(:campaign_id => campaign_id).where(:event_id => event_id).to_a
      campaign_event_ids = campaign_events_row[0][:id]
    end
  end
end