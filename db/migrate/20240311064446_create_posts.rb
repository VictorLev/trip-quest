class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :feed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
