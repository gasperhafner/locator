module Logging
  class FaradayMiddleware
    def initialize(app, logger: Logging::RailsLogger.new)
      @app = app
      @logger = logger
    end

    def call(request_env)
      method = request_env[:method].to_s.upcase
      @logger.debug("Sent request: #{method} #{request_env[:url]}",
                    metadata: {
                        method: request_env[:method],
                        url: request_env[:url].to_s,
                        body: json_or_text(request_env[:body])
                    })
      @app.call(request_env).on_complete do |response_env|
        @logger.debug("Got response: #{response_env[:status]} #{request_env[:url]}",
                      metadata: {
                          method: response_env[:status],
                          body: json_or_text(response_env[:body])
                      })
      end
    end

    def json_or_text(body)
      body ? JSON.parse(body) : nil
    rescue JSON::ParserError
      body
    end
  end
end
