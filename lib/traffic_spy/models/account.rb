module TrafficSpy
  class Account

    attr_reader :identifier

    def initialize(identifier, root_url)
      @identifier = identifier
      @root_url = root_url
    end

    def self.accounts
      DB[:accounts]
    end

    def self.exists?(identifier)
      accounts.where(:identifier => identifier).count > 0
    end

    # def self.make_new_object(identifier)
    #   account_row = DB[:accounts].where(:identifier => identifier).to_a
    #   account_id = account_row[0][:id]
    # end

    def register
      Account.accounts.insert(
        :identifier => @identifier,
        :root_url => @root_url)
      return true
    end

    def self.get_id(identifier)
      account_row = accounts.where(:identifier => identifier).to_a
      account_id = account_row[0][:id]
    end

    def self.destroy_all
      accounts.delete
    end

    def self.count
      accounts.count
    end
  end
end