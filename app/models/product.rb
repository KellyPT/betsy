class Product < ApplicationRecord
  has_many :order_items
  has_many :reviews

  belongs_to :merchant
  belongs_to :category

  validates :name, presence: :true, uniqueness: :true
  validates :price, presence: :true, numericality: {greater_than: 0}
end
