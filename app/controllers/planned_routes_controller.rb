class PlannedRoutesController < ApplicationController

  def index
    @planned_routes = PlannedRoute.includes(:strategic_points).where(user: current_user).order(created_at: :desc)

  end

  def new
    @planned_route = PlannedRoute.new
    @user = current_user

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
    @planned_route = PlannedRoute.new(start_point: planned_route_params[:start_point], end_point: planned_route_params[:end_point], name: planned_route_params[:name], user: current_user)
    planned_route_params[:projected_reward_ids].each do |pr_id|
      if pr_id != ""
        @projected_reward = ProjectedReward.new(strategic_point_id: pr_id)
        @projected_reward.planned_route = @planned_route
        @projected_reward.save
      end
    end
    @planned_route.user = current_user
    if @planned_route.save
      redirect_to user_planned_routes_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @planned_route = PlannedRoute.find(params[:id])
    @planned_route.destroy
    redirect_to user_planned_routes_path(current_user)
  end

  private

  def planned_route_params
    params.require(:planned_route).permit(:start_point, :end_point, :name, :projected_reward_ids => [])
  end
end
