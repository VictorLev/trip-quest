class PlannedRoutesController < ApplicationController
  def show
    if PlannedRoute.all
      @planned_routes = PlannedRoute.first
    end
    @strategicpoints = StrategicPoint.all
    @markers = @strategicpoints.map do |sp|
      {
        lat: sp.latitude,
        lng: sp.longitude,
        # info_window_html: render_to_string(partial: "pages/sp_info", locals: {sp: sp})
      }
    end
  end

  def new

  end
end
