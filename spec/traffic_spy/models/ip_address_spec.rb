require 'spec_helper'

module TrafficSpy
  describe IpAddress do

    before(:each) do
      Account.destroy_all
      Payload.destroy_all
      IpAddress.destroy_all
      ip_address.register
    end

    let (:ip_address){ IpAddress.new("1.2.3.4") }

    it "exists" do
      IpAddress.should be
    end

    it "should take in URL string" do
      instance = IpAddress.new("63.29.38.211")
      expect(instance.ip_address).to eq "63.29.38.211"
    end

    it "tests whether a ip_address already exists" do
      expect(IpAddress.exists?("1.2.3.4")).to be true
    end

    it "registers a new ip_address in the ip_addresses table" do
      expect(ip_address.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(IpAddress.get_id("1.2.3.4")).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(IpAddress.make_new_object("1.2.3.4")).to be_kind_of(Integer)
    end

    it "makes a new object with a new ip_address" do
      expect(IpAddress.make_new_object("2.5.6.7")).to be_kind_of(Integer)
    end
  end
end