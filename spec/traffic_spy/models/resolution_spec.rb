require 'spec_helper'

module TrafficSpy
  describe Resolution do
    before(:each) do
      @resolution = "1080 x 720"
      @resolution_instance = Resolution.new(@resolution)
      @resolution_instance.register
    end

    it "exists" do
      Resolution.should be
    end

    it "should take in Resolution string" do
      instance = Resolution.new("1080x720")
      expect(instance.resolution).to eq "1080x720"
    end

    it "tests whether a resolution already exists" do
      expect(Resolution.exists?(@resolution)).to be true
    end

    it "returns the id of the row in the table" do
      expect(Resolution.get_id(@resolution)).to eq 1
    end

    it "makes a new object with a value that already exists" do
      expect(Resolution.make_new_object(@resolution)).to be_kind_of(Integer)
    end

    it "makes a new object with a new event" do
      expect(Resolution.make_new_object("1280 x 800")).to be_kind_of(Integer)
    end
  end
end