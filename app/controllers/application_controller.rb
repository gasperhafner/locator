class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  helper_method :user_signed_in?
  helper_method :current_user
  helper_method :authenticate

  def home

  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticate!
    unless session[:user_id]
      redirect_to login_path, alert: "Sign in!"
    end
  end
end
