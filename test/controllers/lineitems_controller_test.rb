require 'test_helper'

class LineitemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lineitem = lineitems(:one)
  end

  test "should get index" do
    get lineitems_url
    assert_response :success
  end

  test "should get new" do
    get new_lineitem_url
    assert_response :success
  end

  test "should create lineitem" do
    assert_difference('Lineitem.count') do
      post lineitems_url, params: { product_id: products(:ruby).id }
    end

    assert_redirected_to store_index_url
    follow_redirect!
    assert_select 'h2', 'Your Pragmatic Cart'
    assert_select 'td', 'Programming Ruby 1.9'
  end

  test 'should create lineitem via ajax' do
    assert_difference('Lineitem.count') do
      post lineitems_url, params: {
        product_id: products(:ruby).id
      }, xhr: true
    end

    assert_response :success
    assert_match /lineitem-highlight/, @response.body
  end

  test "should show lineitem" do
    get lineitem_url(@lineitem)
    assert_response :success
  end

  test "should get edit" do
    get edit_lineitem_url(@lineitem)
    assert_response :success
  end

  test "should update lineitem" do
    patch lineitem_url(@lineitem), params: {
      lineitem: { product_id: @lineitem.product_id }
    }
    assert_redirected_to lineitem_url(@lineitem)
  end

  test "should destroy lineitem" do
    assert_difference('Lineitem.count', -1) do
      delete lineitem_url(@lineitem)
      delete lineitem_url(@lineitem)
    end

    assert_redirected_to store_index_url
  end
end
