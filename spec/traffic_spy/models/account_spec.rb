require 'spec_helper'

module TrafficSpy
  describe Account do

    before(:each) do
      Payload.destroy_all
      Account.destroy_all
    end

    let(:account){ Account.new("jumpstartlab", "http://jumpstartlab.com") }

    it "exists" do
      Account.should be
    end

    it "checks to see if there is already an account in the database" do
      account.register
      expect( Account.exists?(account.identifier) ).to be
    end

    describe "#register" do
      it "registers a new account using the parameters from the post request" do
        expect(account.register).to be
      end
    end

    describe ".destroy_all" do
      it "removes all accounts" do
        account.register
        Account.destroy_all
        expect( Account.count ).to eq 0
      end
    end

    describe ".count" do
      it "counts the accounts" do
        expect{ account.register }.to change{ Account.count }.by(1)
      end
    end

    describe ".get_id" do
      it "raises an exception or something if it is not found"
    end
  end
end