module TrafficSpy
  class Browser
    attr_reader :browser

    def initialize(input)
      @browser = input
    end

    def self.exists?(browser)
      DB[:browsers].where(:browser => browser).to_a.count > 0
    end

    def self.get_id(browser)
      browser_row = DB[:browsers].where(:browser => browser).to_a
      browser_id = browser_row[0][:id]
    end

    def self.make_new_object(browser)
      if exists?(browser)
        get_id(browser)
      else
        browser_instance = Browser.new(browser)
        browser_instance.register
        get_id(browser)
      end
    end

    def register
      DB[:browsers].insert(:browser => @browser)
      return true
    end
  end
end