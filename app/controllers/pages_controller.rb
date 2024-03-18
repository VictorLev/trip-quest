class PagesController < ApplicationController
  def dashboard
    @cars = current_user.cars
    @trips = Trip.all.order(created_at: :desc).limit(3)
    @insurers = Insurer.all
    @user = current_user
    @next_level = 100


  end

  def strategic_points
    @strategicpoints = StrategicPoint.all
    @markers = @strategicpoints.map do |sp|
      {
        lat: sp.latitude,
        lng: sp.longitude,
        sp_info_html: render_to_string(partial: "pages/sp_info", locals: {sp: sp})
      }
    end
  end
end
