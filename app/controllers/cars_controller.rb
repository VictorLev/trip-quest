class CarsController < ApplicationController
  before_action :set_user
  before_action :set_car, only: [:edit, :update]

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = @user
    if @car.save
      redirect_to user_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to user_path, notice: 'Car was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to user_path
  end

  private

  def set_user
    @user = current_user
  end

  def set_car
    @car = @user.cars.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:vehicle, :transmission, :color, :year, :kilometers, :price)
  end

end
