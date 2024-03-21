class PagesController < ApplicationController
  def dashboard
    @user = current_user
    @cars = current_user.cars
    @trips = current_user.trips.order(date: :desc).limit(5)
    # @insurers = Insurer.all
    users = User.all
    @users = users.sort_by { |user| user.total_rewards }.reverse
  end

  def strategic_points
    @strategicpoints = StrategicPoint.all
    @markers = @strategicpoints.map do |sp|
      {
        lat: sp.latitude,
        lng: sp.longitude,
        sp_info_html: render_to_string(partial: "pages/sp_info", locals: {sp: sp}),
        marker_html: render_to_string(partial: "planned_routes/marker", locals: {sp: sp})
      }
    end
  end

  def new_level
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
end
