class AddPriceToLineitems < ActiveRecord::Migration[6.0]
  def change
    add_column :lineitems, :price, :decimal, precision: 8, scale: 2
  end
end
