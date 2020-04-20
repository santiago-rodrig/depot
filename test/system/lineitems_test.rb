require "application_system_test_case"

class LineitemsTest < ApplicationSystemTestCase
  setup do
    @lineitem = lineitems(:one)
  end

  test "visiting the index" do
    visit lineitems_url
    assert_selector "h1", text: "Lineitems"
  end

  test "creating a Lineitem" do
    visit lineitems_url
    click_on "New Lineitem"

    fill_in "Cart", with: @lineitem.cart_id
    fill_in "Product", with: @lineitem.product_id
    click_on "Create Lineitem"

    assert_text "Lineitem was successfully created"
    click_on "Back"
  end

  test "updating a Lineitem" do
    visit lineitems_url
    click_on "Edit", match: :first

    fill_in "Cart", with: @lineitem.cart_id
    fill_in "Product", with: @lineitem.product_id
    click_on "Update Lineitem"

    assert_text "Lineitem was successfully updated"
    click_on "Back"
  end

  test "destroying a Lineitem" do
    visit lineitems_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lineitem was successfully destroyed"
  end
end
