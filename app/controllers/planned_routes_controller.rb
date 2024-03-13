class PlannedRoutesController < ApplicationController
  def show
    if PlannedRoute.all
      @planned_routes = PlannedRoute.first
    end
  end

  def new

  end
end
