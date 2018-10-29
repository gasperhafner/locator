module Api
  class Client < Api::Base
    DEFAULT_HEADERS = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }.freeze

    def initialize
      @conn = Faraday.new(
        headers: DEFAULT_HEADERS
      )
    end
  end
end
