require 'spec_helper'

module TrafficSpy
  describe "campaign" do
    it "exists" do
      Campaign.should be
    end
  end

  describe "campaign" do
    before(:each) do
      @campaign = "socialSignup"
      @campaign_instance = Campaign.new(@campaign)
    end

    it "tests whether a campaign already exists" do
      expect(Campaign.exists?(@campaign)).to be_true
    end

    it "returns the id associated with the campaing" do
      expect(Campaign.get_id(@campaign)).to eq 1
    end

    it "makes a new campaign object" do
      expect(Campaign.make_new_object(@campaign)).to be_a_kind_of(Integer)
    end

    it "registers a campaign" do
      expect(@campaign_instance.register).to be_true
    end

    # it "sorts campaigns according to most associated events" do
    #   expect(Campaign.sorted_campaigns("jumpstartlab")).to be_a_kind_of(Hash)
    # end

    
  end
end