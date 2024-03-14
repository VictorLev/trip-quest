class TripsController < ApplicationController
  def index

    @trips = Trip.all
    @user = current_user
    @cars = @user.cars

    @total_points = []

    @trips.each do |trip|
      @total_points << trip.reward_point
    end

  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = @user
    if @trip.save
      redirect_to user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:start_point, :end_point, :reward_point, :date, :name)
  end
end
