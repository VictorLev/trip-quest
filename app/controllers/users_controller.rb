class UsersController < ApplicationController
  def show
    @user = current_user
    @cars = Car.where(user: @user)
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :gender, :age, :photo)
  end
end
