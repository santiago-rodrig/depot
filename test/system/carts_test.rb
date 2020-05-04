require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  test 'add to cart reveals the cart' do
    visit store_index_url
    assert_no_selector '#cart'
    click_on 'Add to cart', match: :first
    assert_selector '#cart'
  end

  test 'empty cart hides the cart' do
    visit store_index_url
    click_on 'Add to cart', match: :first

    accept_alert do
      click_on 'Empty cart'
    end

    assert_no_selector '#cart'
  end
end
