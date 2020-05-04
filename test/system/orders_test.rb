require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  test 'check routing number' do
    visit store_index_url
    click_on 'Add to cart', match: :first
    click_on 'Checkout'
    fill_in 'order_name', with: 'Santiago Rodríguez'
    fill_in 'order_address', with: '123 Calle las Palmas'
    fill_in 'order_email', with: 'santiago@example.com'
    assert_no_selector '#order_routing_number'
    select 'Check', from: 'Pay type'
    assert_selector '#order_routing_number'
  end

  test 'credit card fields' do
    visit store_index_url
    click_on 'Add to cart', match: :first
    click_on 'Checkout'
    fill_in 'order_name', with: 'Santiago Rodríguez'
    fill_in 'order_address', with: '123 Calle las Palmas'
    fill_in 'order_email', with: 'santiago@example.com'
    assert_no_selector '#order_credit_card_number'
    assert_no_selector '#order_expiry_date'
    select 'Credit card', from: 'Pay type'
    assert_selector '#order_credit_card_number'
    assert_selector '#order_expiration_date'
  end

  test 'purchase order number' do
    visit store_index_url
    click_on 'Add to cart', match: :first
    click_on 'Checkout'
    fill_in 'order_name', with: 'Santiago Rodríguez'
    fill_in 'order_address', with: '123 Calle las Palmas'
    fill_in 'order_email', with: 'santiago@example.com'
    assert_no_selector '#order_po_number'
    select 'Purchase order', from: 'Pay type'
    assert_selector '#order_po_number'
  end
end
