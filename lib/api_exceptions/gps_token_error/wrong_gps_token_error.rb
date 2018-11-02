module ApiExceptions
  class GpsTokenError < ApiExceptions::BaseException
    class WrongGpsTokenError < ApiExceptions::GpsTokenError
    end
  end
end
