module Api::Pushbullet
  class Base < ::Api::Base
    DEFAULT_HEADERS = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
    }.freeze

    def initialize(logger: Logging::RailsLogger.new, access_token: nil)
      raise "Access token  not set." unless access_token

      url = base_url
      headers = {"Access-Token" => "#{access_token}"}
      @conn = Faraday.new(url: url, headers: DEFAULT_HEADERS.merge(headers)) do |faraday|
        faraday.request :retry, max: 2
        faraday.use Logging::FaradayMiddleware, logger: logger
        faraday.adapter Faraday.default_adapter
      end
    end

    private

    def base_url
      "https://api.pushbullet.com/v2/"
    end
  end
end
