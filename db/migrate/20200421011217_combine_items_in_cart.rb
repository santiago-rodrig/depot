class CombineItemsInCart < ActiveRecord::Migration[6.0]
  def up
    # replace multiple items for a single product in a cart
    # with the corresponding frequency of coincidences
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.lineitems.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # delete all line items with the corresponding product id
          cart.lineitems.where(product_id: product_id).delete_all
          # build the item
          item = cart.lineitems.build(product_id: product_id)
          item.quantity = quantity
          item.save! # raise an exception in case of troubles
        end
      end
    end
  end
  def down
    # split items with a quantity greater than one in single items
    Lineitem.where('quantity > 1').each do |item|
      item.quantity.times do
        Lineitem.create!(
          cart_id: item.cart_id,
          product_id: item.product_id,
          quantity: 1
        )
      end
      item.destroy!
    end
  end
end
