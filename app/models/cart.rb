class Cart < ApplicationRecord
  has_many :lineitems, dependent: :destroy
end
