class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  helper_method :user_signed_in?
  helper_method :current_user
  helper_method :authenticate!

  def home

  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    if cookies.encrypted[:user_id]
      @current_user ||= User.find(cookies.encrypted[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticate!
    unless cookies.encrypted[:user_id]
      redirect_to login_path
    end
  end
end
