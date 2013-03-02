require 'spec_helper'

module TrafficSpy
  describe Account do
    it "exists" do
      Account.should be
    end

    it "registers a new account using the parameters from the post request" do
      account_info = {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
      expect(Account.register(account_info)).should be_true
    end
  end
end