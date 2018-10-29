module Api
  class Error < StandardError
    attr_reader :response

    def initialize(response)
      super
      @response = response
    end
  end
end
