class UsersController < ApplicationController
  before_action :authenticate!

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_user_path(current_user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :pushbullet_token, :recipient)
  end
end
