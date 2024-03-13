class CreateActualRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :actual_rewards do |t|
      t.references :strategic_point, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
