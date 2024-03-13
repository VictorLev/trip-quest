class CreatePlannedRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :planned_routes do |t|
      t.string :name, null: false
      t.string :start_point
      t.string :end_point
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
