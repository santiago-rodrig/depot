class ChangeOrdersPayType < ActiveRecord::Migration[6.0]
  def change
    change_table :orders do |t|
      t.remove :pay_type
      t.references :pay_type
    end
  end
end
