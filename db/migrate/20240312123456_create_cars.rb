class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :vehicle
      t.string :transmission
      t.string :color
      t.integer :year
      t.integer :kilometers
      t.integer :price
      t.integer :insurer_id
      t.integer :user_id
      t.timestamps
    end
  end
end
