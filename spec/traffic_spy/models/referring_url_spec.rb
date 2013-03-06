require 'spec_helper'

module TrafficSpy
  describe ReferringUrl do
    before(:each) do
      Account.destroy_all
      Payload.destroy_all
      ReferringUrl.destroy_all
      referring_url.register
    end

    let (:referring_url){ ReferringUrl.new("http://dax.com") }

    it "exists" do
      ReferringUrl.should be
    end

    it "tests whether a referring URL already exists" do
      expect(ReferringUrl.exists?("http://dax.com")).to be true
    end

    it "registers a new referring Url in the URLs table" do
      expect(referring_url.register).to eq true
    end

    it "makes a new object with a value that already exists" do
      expect(ReferringUrl.make_new_object("http://dax.com")).to be_kind_of(Integer)
    end

    it "returns the id of the row in the table" do
      expect(ReferringUrl.get_id("http://dax.com")).to be_kind_of(Integer)
    end
  end
end