class Merchant < ApplicationRecord
  has_many :products
  validates :email, :uid, :provider, presence: true

  def self.build_from_github(auth_hash)
    merchant           = Merchant.new
    merchant.uid       = auth_hash[:uid]
    merchant.provider  = 'github'
    merchant.user_name = auth_hash['info']['nickname']
    merchant.email     = auth_hash['info']['email']

    return merchant
  end

  def get_merchant_orders(status = nil)
  # "Order" to merchant is the order_items they must fulfill
    order_items = OrderItem.joins(:order, :product)
.where('products.merchant_id = ?', self.id)

  # narrow the seach to specific status if status is provided
    unless status.nil?
      order_items = order_items.where('orders.order_status = ?', status)
    end

    return order_items

  end

end
