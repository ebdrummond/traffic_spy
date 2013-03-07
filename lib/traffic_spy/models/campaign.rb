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
  end
end