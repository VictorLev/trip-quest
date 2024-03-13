class CreateStrategicPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :strategic_points do |t|
      t.string :address
      t.integer :danger, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
