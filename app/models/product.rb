class Product < ApplicationRecord
  has_many :order_items
  has_many :reviews

  belongs_to :merchant

  has_many :categories, through: :categories_products
  has_many :categories_products

  validates :name, presence: :true, uniqueness: :true
  validates :price, presence: :true, numericality: {greater_than: 0}
  validates :merchant_id, presence: :true


  # TODO: We cannot call check_availability in this method, because it prevents us from updating the
  # amount positively. We need to call check_availability in the context of buying things. But
  # if the Merchant wants to add more inventory, checking availability makes no sense, and in fact
  # breaks things. :(

  def update_quantity(number)
    number = number.to_i
    # if check_availability(number)

    return self.quantity += number if (self.quantity + number) >= 0
    # end
  end

  def check_availability(number)
    self.quantity >= number
  end

end
