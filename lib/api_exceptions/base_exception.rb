module ApiExceptions
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status, :code, :message

    ERROR_DESCRIPTION = Proc.new {|code, message| {status: :error, code: code, message: message}}

    ERROR_CODE_MAP = {
      "GpsTokenError::MissingGpsTokenError" => ERROR_DESCRIPTION.call(400, "GPS token is missing."),
      "GpsTokenError::WrongGpsTokenError" => ERROR_DESCRIPTION.call(400, "GPS token is not valid."),
    }
    def initialize
      error_type = self.class.name.scan(/ApiExceptions::(.*)/).flatten.first
      ApiExceptions::BaseException::ERROR_CODE_MAP
        .fetch(error_type, {}).each do |attr, value|
        instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end
end
