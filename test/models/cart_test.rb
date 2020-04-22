require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test 'add the same product twice' do
    cart = carts(:one)
    item = cart.add_product(products(:ruby))
    assert_equal 3, item.quantity
  end

  test 'add a different product' do
    cart = carts(:one)
    item = cart.add_product(products(:docker))
    assert_equal cart, item.cart
    assert_equal 1, item.quantity
    assert item.new_record?
  end
end
