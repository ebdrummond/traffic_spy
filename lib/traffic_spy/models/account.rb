module TrafficSpy
  class Account

    def initialize(identifier, root_url)
      @identifier = identifier
      @root_url = root_url
    end

    def exists?(identifier)
      DB[:accounts].where(:identifier => identifier).to_a.count > 0
    end

    def register(params)
      DB[:accounts].insert(
        :id => params[:id],
        :identifier => params[:identifier],
        :root_url => params[:rootUrl])
      return true
    end
  end
end