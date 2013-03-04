require 'spec_helper'

module TrafficSpy
  describe OperatingSystem do
    before(:each) do
      @operating_system = "Windows"
      @operating_system_instance = OperatingSystem.new(@operating_system)
      @operating_system_instance.register
    end

    it "exists" do
      OperatingSystem.should be
    end

    it "should take in URL string" do
      instance = OperatingSystem.new("Mac OS X 10_8_2")
      expect(instance.operating_system).to eq "Mac OS X 10_8_2"
    end

     it "tests whether an operating_system already exists" do
      expect(OperatingSystem.exists?(@operating_system)).to be true
    end

    it "registers a new operating_system in the operating systems table" do
      expect(@operating_system_instance.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(OperatingSystem.get_id(@operating_system)).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(OperatingSystem.make_new_object(@operating_system)).to be_kind_of(Integer)
    end

    it "makes a new object with a new operating_system" do
      expect(OperatingSystem.make_new_object("Linux")).to be_kind_of(Integer)
    end

    it "returns operating systems breakdown" do
      expect(OperatingSystem.breakdown("jumpstartlab")).to be_kind_of(Hash)
    end
  end
end