class Order < ApplicationRecord
  belongs_to :pay_type
  has_many :lineitems, dependent: :destroy

  validates :name, :address, :email, presence: true

  def add_lineitems_from_cart(cart)
    cart.lineitems.each do |item|
      item.cart_id = nil
      lineitems << item
    end
  end
end
