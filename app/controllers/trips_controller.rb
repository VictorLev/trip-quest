class TripsController < ApplicationController
  def index
    @user = current_user
    @cars = @user.cars
    @trips = @user.trips.sort_by{ |trip| trip.date}.reverse
    @trips_last_month = @trips.select { |trip| trip.date >= Date.today - 1.month }
    if params[:trip] && params[:trip][:car] != ""
      @trips = @trips.select { |trip| trip.car == Car.find(params[:trip][:car])}
    end
    if params[:trip] && params[:trip][:start_date] != "" && params[:trip][:end_date] != ""
      @trips = @trips.select { |trip| trip.date >= params[:trip][:start_date].to_date && trip.date <= params[:trip][:end_date].to_date }
    end

    @total_points = []
    @total_points_last_month = []

    @trips_last_month.each do |trip|
      @total_points_last_month << trip.reward_point
    end

    @trips.each do |trip|
      @total_points << trip.reward_point
    end

  end

  def new
    @trip = Trip.new
    @user = current_user

    @strategicpoints = StrategicPoint.all

    @markers = @strategicpoints.map do |sp|
      {
        id: sp.id,
        lat: sp.latitude,
        lng: sp.longitude,
        sp_info_html: render_to_string(partial: "planned_routes/sp_info", locals: {sp: sp}),
        marker_html: render_to_string(partial: "planned_routes/marker", locals: {sp: sp})
      }
    end
  end

  def create
    current_date = Date.today
    @trip = Trip.new(
      date: current_date,
      name: trip_params[:name],
      car_id: trip_params[:car_id],
      start_point: trip_params[:start_point],
      end_point: trip_params[:end_point],
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
    @strategicpoints = StrategicPoint.where(id: @trip.actual_rewards.map(&:strategic_point_id))
    @markers = @strategicpoints.map do |sp|
      {
        id: sp.id,
        lat: sp.latitude,
        lng: sp.longitude,
        sp_info_html: render_to_string(partial: "planned_routes/sp_info", locals: {sp: sp}),
        marker_html: render_to_string(partial: "planned_routes/marker", locals: {sp: sp})
      }
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:start_point, :end_point, :date, :car_id, :name, :actual_reward_ids => [] )
  end
end
