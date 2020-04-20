require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
  end

  test "can't delete product in cart" do
    assert_no_difference('Product.count') do
      delete product_url(products(:two))
    end

    assert_redirected_to products_url
  end

  test "should get index" do
    get products_url
    assert_response :success
    assert_select 'h1', 'Products'
    assert_select 'a[href=?]', new_product_path, text: 'New Product'

    Product.all.each do |product|
      assert_select 'img', src: { match: /#{product.image_url}/ }
      assert_select 'a[href=?]', product_path(product), text: 'Show'
      assert_select 'a[href=?]', edit_product_path(product), text: 'Edit'

      assert_select 'a[href=?][data-method=?]', product_path(product),
        'delete', text: 'Destroy'

      assert_select 'p', match: /#{product.description.gsub(/<.*>/, '')[0, 80]}/
    end
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: {
        product: {
          description: @product.description,
          image_url: @product.image_url,
          price: @product.price,
          title: @title
        }
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: {
      product: {
        description: @product.description,
        image_url: @product.image_url,
        price: @product.price,
        title: @title
      }
    }

    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
