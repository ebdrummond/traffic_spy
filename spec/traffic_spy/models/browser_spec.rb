require 'spec_helper'

module TrafficSpy
  describe Browser do
    before(:each) do
      @browser = "Chrome"
      @browser_instance = Browser.new(@browser)
      @browser_instance.register
    end

    it "exists" do
      Browser.should be
    end

    it "should take in Browser string" do
      instance = Browser.new("Chrome")
      expect(instance.browser).to eq "Chrome"
    end

    it "tests whether a browser already exists" do
      expect(Browser.exists?(@browser)).to be true
    end

    it "registers a new browser in the browsers table" do
      expect(@browser_instance.register).to eq true
    end

    it "returns the id of the row in the table" do
      expect(Browser.get_id(@browser)).to be_kind_of(Integer)
    end

    it "makes a new object with a value that already exists" do
      expect(Browser.make_new_object(@browser)).to be_kind_of(Integer)
    end

    it "makes a new object with a new browser" do
      expect(Browser.make_new_object("Firefox")).to be_kind_of(Integer)
    end

    it "returns browser breakdown across requests" do
      expect(Browser.breakdown("jumpstartlab")).to be_kind_of(Hash)
    end
  end
end