class Api::V1::BaseController < ActionController::API

  rescue_from ApiExceptions::BaseException,
              :with => :render_error_response

  def render_error_response(error)
    render json: {status: error.status, message: error.message, code: error.code}, status: 200
  end
end
