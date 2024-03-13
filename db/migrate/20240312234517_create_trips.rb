class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.string :start_point, null: false
      t.string :end_point, null: false
      t.integer :reward_point
      t.date :date, null: false
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
