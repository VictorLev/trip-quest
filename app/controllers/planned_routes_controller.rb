class PlannedRoutesController < ApplicationController

  def index
    @planned_routes = PlannedRoute.where(user: current_user)
  end

  def new
    @planned_route = PlannedRoute.new
    @user = current_user
    # if PlannedRoute.all
    #   @planned_routes = PlannedRoute.first
    # end

    @strategicpoints = StrategicPoint.all

    @markers = @strategicpoints.map do |sp|
      {
        lat: sp.latitude,
        lng: sp.longitude,
        sp_info_html: render_to_string(partial: "planned_routes/sp_info", locals: {sp: sp})
      }
    end
  end

  def create
    @planned_route = PlannedRoute.new(planned_route_params)
    @planned_route.user = current_user
    if @planned_route.save
      redirect_to user_planned_routes_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def planned_route_params
    params.require(:planned_route).permit(:start_point, :end_point, :name)
  end
end
