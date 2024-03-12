class CreateInsurers < ActiveRecord::Migration[7.1]
  def change
    create_table :insurers do |t|
      t.string :name
      t.integer :min_threshold

      t.timestamps
    end
  end
end
