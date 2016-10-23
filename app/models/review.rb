class Review < ApplicationRecord
  belongs_to :product

  validates :rating, numericality: {greater_than: 0, lesser_than_or_equal_to: 5}
end
