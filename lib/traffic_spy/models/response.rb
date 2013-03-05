module TrafficSpy
  class Response
    attr_reader :status, :body

    def initialize(status = 200, body = "")
      @status = status
      @body   = body
    end
  end
end