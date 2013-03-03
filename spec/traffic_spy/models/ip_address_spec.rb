require 'spec_helper'

module TrafficSpy
  describe IpAddress do

    before(:each) do
      @ip_address = "1.2.3.4.5"
      @ip_address_instance = IpAddress.new(@ip_address)
      @ip_address_instance.register
    end

    it "exists" do
      IpAddress.should be
    end

    it "should take in URL string" do
      instance = IpAddress.new("63.29.38.211")
      expect(instance.ip_address).to eq "63.29.38.211"
    end

    it "tests whether a ip_address already exists" do
      expect(IpAddress.exists?(@ip_address)).to be true
    end

    it "should take in ip_address string" do
      instance = IpAddress.new("socialLogin")
      expect(instance.ip_address).to eq "socialLogin"
    end

    it "registers a new ip_address in the ip_addresses table" do
      expect(@ip_address_instance.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(IpAddress.get_id(@ip_address)).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(IpAddress.make_new_object(@ip_address)).to be_kind_of(Integer)
    end

    it "makes a new object with a new ip_address" do
      expect(IpAddress.make_new_object("2.5.6.7.8")).to be_kind_of(Integer)
    end
  end
end