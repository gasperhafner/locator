module Logging
  class RailsLogger
    def debug(msg, _opts)
      Rails.logger.debug(msg)
    end

    def info(msg, _opts)
      Rails.logger.info(msg)
    end

    def warn(msg, _opts)
      Rails.logger.warn(msg)
    end

    def error(msg, _opts)
      Rails.logger.error(msg)
    end

    def fatal(msg, _opts)
      Rails.logger.fatal(msg)
    end
  end
end
