require 'spec_helper'

module TrafficSpy
  describe Account do

    before(:each) do
      @account = Account.new("erin", "http://jumpstartlab.com")
    end

    it "exists" do
      Account.should be
    end

    it "checks to see if there is already an account in the database" do
      expect(Account.exists?(@account.identifier)).to be true
    end

    it "registers a new account using the parameters from the post request" do
      expect(@account.register).to be true
    end

    # it "returns a 403 status code for a duplicate account" do
    #   post "/sources", @account
    #   last_response.status.should eq 403
    # end
  end
end