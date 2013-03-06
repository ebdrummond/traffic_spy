require 'spec_helper'

module TrafficSpy
  describe Campaign do
    before(:each) do
      Account.destroy_all
      Payload.destroy_all
      Campaign.destroy_all
      campaign.register
    end

    let (:campaign){ Campaign.new("socialLogin") }

    it "exists" do
      Campaign.should be
    end

    it "tests whether a campaign already exists" do
      expect(Campaign.exists?("socialLogin")).to be_true
    end

    it "returns the id associated with the campaing" do
      expect(Campaign.get_id("socialLogin")).to be_a_kind_of(Integer)
    end

    it "makes a new campaign object" do
      expect(Campaign.make_new_object("socialLogin")).to be_a_kind_of(Integer)
    end

    it "registers a campaign" do
      expect(campaign.register).to be_true
    end
  end
end