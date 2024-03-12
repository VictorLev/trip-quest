class UsersController < ApplicationController
  def show
    @user = current_user
    @cars = Car.where(user: @user)
  end

  def update
    @user = current_user
    @user.update(user_params)

    respond_to do |format|
      format.html { redirect_to user_path }
      format.text { render partial: "users/user_infos", locals: {user: @user}, formats: [:html] }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :gender, :age)
  end
end
