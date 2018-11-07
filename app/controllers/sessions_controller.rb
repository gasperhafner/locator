class SessionsController < ApplicationController
  before_action :redirect, only: [:new, :create, :confirmation]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      unless user.active?
        UserMailer.confirmation(user).deliver_later
        redirect_to login_path, login_notice: "To finish signing up, confirm your email and you're good to go!"
        return
      end
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:login_alert] = "Email or password is invalid"
      render "new"
    end
  end

  def confirmation
    user = User.find_by(confirmation_token: params[:token])
    if user
      if user.active?
        redirect_to login_path, alert: "You already confirmed your account, please log in."
        return
      end
      user.update(active: true)
      session[:user_id] = user.id
      redirect_to root_path, notice: "You were automatically logged in. Have a great time using our app."
    else
      flash[:login_alert] = "Wrong confirmation token."
      redirect_to login_path
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
