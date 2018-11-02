module ApiExceptions
  class GpsTokenError < ApiExceptions::BaseException
    class MissingGpsTokenError < ApiExceptions::GpsTokenError
    end
  end
end
