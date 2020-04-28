class AddOrderToLineitems < ActiveRecord::Migration[6.0]
  def change
    add_reference :lineitems, :order, null: true, foreign_key: true
    change_column :lineitems, :cart_id, :integer, null: true
  end
end
