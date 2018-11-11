class UsersController < ApplicationController
  before_action :authenticate!, only: [:edit, :update, :send_test_push]

  def new
    @user = User.new
  end

  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.confirmation(@user).deliver_later
      flash[:login_notice] = "To finish signing up, confirm your email and you're good to go!"
      redirect_to root_path
    else
      render :new
    end
  end

  def reset_password

  end

  def update
    if current_user.update(user_params)
      redirect_to edit_user_path(current_user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def send_test_push
    pushbullet_client =
      pushbullet_client(current_user.pushbullet_token)

    response =
      pushbullet_client.create(
        {
          body: "Test successfully passed.",
          title: "poisci.ga push notification",
          url: "https://poisci.ga",
          type: "link"
        }
      )

    current_user.push_logs.create!(
      sender: response["sender_email"],
      receiver: response["receiver_email"],
      title: response["title"],
      url: response["url"]
    )

    flash[:push_success] = "Push notification was successfully sent!"
    respond_to do |format|
      format.js
    end

  rescue Api::ClientError => e
    flash[:push_alert] = "Pushbullet access token is missing or invalid."
    respond_to do |format|
      format.js
    end
  end

  private

  def pushbullet_client(access_token)
    Api::Pushbullet::Push.new(access_token: access_token)
  end

  def user_params
    params.require(:user).permit(
      :email,
      :pushbullet_token,
      :recipient,
      :password,
      :password_confirmation,
      :stream_location
    )
  end
end
