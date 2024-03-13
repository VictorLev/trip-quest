class TripsController < ApplicationController
  def index
    @trips = Trip.all
    @markers = @trips.geocoded.map do |trip|
      {
        lat: trip.latitude,
        lng: trip.longitude
      }
    end
  end
end
