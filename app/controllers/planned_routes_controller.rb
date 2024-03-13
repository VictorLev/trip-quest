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
      }
    end
  end

  def create
    raise
    @planned_route = PlannedRoute.new(planned_route_params)
    @planned_route.user = current_user
    if @planned_route.save
      redirect_to user_planned_routes(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def planned_route_params
    params.require(:planned_route).permit(:origin, :destination)
  end
end
