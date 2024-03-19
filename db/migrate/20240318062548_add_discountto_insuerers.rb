class AddDiscounttoInsuerers < ActiveRecord::Migration[7.1]
  def change
    add_column :insurers, :discount, :integer
  end
end
