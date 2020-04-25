class StoreController < ApplicationController
  include CurrentCart

  before_action :set_cart

  def index
    session[:counter] ||= 0
    session[:counter] += 1
    @counter = session[:counter]
    @products = Product.order(:title)
  end
end
