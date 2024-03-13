class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def dashboard
  end

  def strategic_points
    @strategicpoints = StrategicPoint.all
    @markers = @strategicpoints.map do |sp|
      {
        lat: sp.latitude,
        lng: sp.longitude
      }
    end
  end
end
