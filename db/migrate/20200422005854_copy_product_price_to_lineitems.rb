class CopyProductPriceToLineitems < ActiveRecord::Migration[6.0]
  def up
    Lineitem.all.each do |item|
      item.price = item.product.price
      item.save
    end
  end

  def down
    Lineitem.all.each do |item|
      item.price = nil
    end
  end
end
