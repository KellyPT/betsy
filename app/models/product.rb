class Product < ApplicationRecord
  has_many :order_items
  has_many :reviews
  
  belongs_to :merchant

  has_many :categories, through: :categories_products
  has_many :categories_products

  validates :name, presence: :true, uniqueness: :true
  validates :price, presence: :true, numericality: {greater_than: 0}
  validates :merchant_id, presence: :true

  def update_quantity(number)
    # things from the internet come through as string, change to_i
    number = number.to_i
    if (self.quantity + number) < 0
      return false
    end
    return self.quantity += number
  end
end
