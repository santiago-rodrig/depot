class Product < ApplicationRecord
  has_many :lineitems
  has_many :orders, through: :lineitems

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01, message: 'Price must be at least 1 cent' }
  validates :title, uniqueness: true, length: { minimum: 10 }

  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    { title: title, orders: orders }
  end

  private

  def ensure_not_referenced_by_any_line_item
    unless lineitems.empty?
      errors.add(:base, 'Line items present')
      throw :abort
    end
  end
end
