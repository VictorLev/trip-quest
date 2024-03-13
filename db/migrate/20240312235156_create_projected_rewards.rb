class CreateProjectedRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :projected_rewards do |t|
      t.references :strategic_point, null: false, foreign_key: true
      t.references :planned_route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
