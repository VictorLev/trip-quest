class TripsController < ApplicationController
  def index
    @trips = Trip.all
    @markers = @trips.geocoded.map do |trip|
      {
        lat: trip.latitude,
        lng: trip.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { trip: trip }),
        marker_html: render_to_string(partial: "marker", locals: { trip: trip })
      }
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = @user
    if @trip.save
      redirect_to user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

end
