class AddCoordinatesToTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :latitude, :float
    add_column :trips, :longitude, :float
  end
end
