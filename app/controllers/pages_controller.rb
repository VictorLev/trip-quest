class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def dashboard
  end

  def strategic_points
    @strategicpoints = StrategicPoint.all
    @markers = @strategicpoints.map do |sp|
      {
        lat: sp.latitude,
        lng: sp.longitude,
        info_window_html: render_to_string(partial: "pages/sp_info", locals: {sp: sp})
      }
    end
  end
end
