class PagesController < ApplicationController
  def dashboard
    @user = current_user
    @cars = current_user.cars
    @trips = current_user.trips.order(date: :desc)
    # @insurers = Insurer.all
    users = User.all
    @users = users.sort_by { |user| user.total_rewards }.reverse

    @chart = @trips.map { |trip| [trip[:date], trip[:reward_point]] }

    @grouped_trips = @trips.group_by_week {|trip| trip[:date].strftime("%a %b '%y") }
    # raise
    # @chart_two = Trip
    #             .all
    #             .select("DATE_TRUNC('week', date) AS week", "SUM(reward_point) AS reward_point_sum")
    #             .group("week")
    # sql = "SELECT date_trunc('month', date)::date, SUM(reward_point)
    # FROM trips
    # JOIN cars ON trips.car_id = cars.id
    # JOIN users ON cars.user_id = users.id
    # WHERE users.id = :user_id
    # GROUP BY 1"
    # @chart_two = Trip.where(sql, user_id: current_user.id)

    # @chart.group_by_week {|a| a[0].strftime("Week beginning %a/%m/%y") }
    # => {Sun, 18 Feb 2024=>[[Wed, 28 Feb 2024, 200]], Sun, 17 Mar 2024=>[[Thu, 21 Mar 2024, 250], [Thu, 21 Mar 2024, 250], [Sun, 10 Mar 2024, 200], [Thu, 07 Mar 2024, 200], [Tue, 05 Mar 2024, 200]]}
    # => {Sun, 25 Feb 2024=>[[Wed, 28 Feb 2024, 200]], Sun, 03 Mar 2024=>[[Sun, 10 Mar 2024, 200], [Thu, 07 Mar 2024, 200], [Tue, 05 Mar 2024, 200]], Sun, 17 Mar 2024=>[[Thu, 21 Mar 2024, 250], [Thu, 21 Mar 2024, 250]]} %>

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
