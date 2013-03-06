module TrafficSpy
  class Campaign
    attr_reader :campaign

    def initialize(input)
      @campaign = input
    end

    def self.exists?(campaign)
      DB[:campaigns].where(:campaign => campaign).to_a.count > 0
    end

    def self.get_id(campaign)
      campaign_row = DB[:campaigns].where(:campaign => campaign).to_a
      campaign_id = campaign_row[0][:id]
    end

    def self.make_new_object(campaign)
      if exists?(campaign)
        get_id(campaign)
      else
        campaign_instance = campaign.new(campaign)
        campaign_instance.register
        get_id(campaign)
      end
    end

    def self.destroy_all
      DB[:campaigns].delete
    end

    def register
      DB[:campaigns].insert(:campaign => @campaign)
      return true
    end

    # def self.sorted_campaigns(identifier)
    #   campaigns = DB[:campaigns]
    #   payloads = DB[:payloads]
    #   account_id = Account.get_id(identifier)

    #   campaign_sorted_hash = Hash.new(0)
    #   campaign_ids_by_count = payloads.where(:account_id => account_id).join(:campaigns, :id => :campaign_id).group_and_count(:campaign_id).order(Sequel.desc(:count))
    #   campaign_ids_by_count.to_a.each do |campaign_row|
    #     campaign_id = campaign_row[:campaign_id]
    #     actual_campaign_query = DB[:campaigns].where(:id => campaign_id).to_a
    #     actual_campaign = actual_campaign_query[0][:campaign]
    #     campaign_sorted_hash[actual_campaign] += campaign_row[:count]
    #   end
    #   campaign_sorted_hash
    # end
  end
end