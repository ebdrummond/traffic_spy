module TrafficSpy
  class Request
    attr_reader :json_input

    def initialize(json_input)
      @json_input = json_input
      
    end
  end
end