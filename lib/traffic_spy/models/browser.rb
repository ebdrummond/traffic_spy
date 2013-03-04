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

    def self.breakdown(identifier)
      browsers = DB[:browsers]
      payloads = DB[:payloads]
      account_id = Account.get_id(identifier)

      browsers_hash = Hash.new(0)
      browsers_by_account_id = payloads.where(:account_id => account_id).join(:browsers, :id => :browser_id).group_and_count(:browser_id).order(Sequel.desc(:count))
      browsers_by_account_id.to_a.each do |browser_row|
        browser_id = browser_row[:browser_id]
        actual_browser_query = DB[:browsers].where(:id => browser_id).to_a
        actual_browser = actual_browser_query[0][:browser]
        browsers_hash[actual_browser] += browser_row[:count]
        puts browsers_hash
      end
      browsers_hash
    end
  end
end