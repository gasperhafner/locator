class SessionsController < ApplicationController
  before_action :redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])

      unless user.active?
        redirect_to login_path, notice: "To finish signing up, confirm your email and you're good to go!"
        return
      end

      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:login_alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def redirect
    if user_signed_in?
      redirect_to root_path
    end
  end
end
