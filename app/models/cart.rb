class Cart < ApplicationRecord
  has_many :lineitems, dependent: :destroy

  def add_product(product)
    current_item = lineitems.find_by(product_id: product.id)

    if current_item
      current_item.quantity += 1
    else
      current_item = lineitems.build(product_id: product.id)
      current_item.price = product.price
    end

    current_item
  end

  def total_price
    lineitems.to_a.sum { |item| item.total_price }
  end
end
