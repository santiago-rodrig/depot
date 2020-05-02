class PayType < ApplicationRecord
  has_many :orders, dependent: :destroy
end
