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
  end
end
