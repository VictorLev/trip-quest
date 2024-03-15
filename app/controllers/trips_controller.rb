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
    @user = current_user
  end

  def create


    @start_point = Geocoder.search(trip_params[:start_point]).first.coordinates.join(",")
    @end_point = Geocoder.search(trip_params[:end_point]).first.coordinates.join(",")
    @trip = Trip.new(
      date: trip_params[:date],
      name: trip_params[:name],
      car_id: trip_params[:car_id],
      start_point: @start_point,
      end_point: @end_point,
      )
    trip_params[:actual_reward_ids].each do |ar_id|
      if ar_id != ""
        @actual_reward = ActualReward.new(strategic_point_id: ar_id)
        @actual_reward.trip = @trip
        @actual_reward.save
      end
    end

    @trip.reward_point = @trip.sum_reward

    if @trip.save
      redirect_to trips_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

  private

  def trip_params
    params.require(:trip).permit(:start_point, :end_point, :date, :car_id, :name, :actual_reward_ids => [] )
  end
end
