require 'spec_helper'

module TrafficSpy
  describe Response do
    it "has a status" do
      expect( Response.new(200).status ).to eq 200
    end

    it "can have a body" do
      expect( Response.new(200, "Hello!").body).to eq "Hello!"
    end

    it "defaults to status 200 OK" do
      expect( Response.new.status ).to eq 200
    end
  end
end