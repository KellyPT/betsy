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

  def get_merchant_orders
    merchant_orders = []
    products = self.products
    products.each do |product|
      order_items = product.order_items
        order_items.each do |item|
          merchant_orders << item
        end
    end
    return merchant_orders
  end

  def get_merchant_orders_by_status(status)
    merchant_orders = []
    products = self.products
    products.each do |product|
      order_items = product.order_items
      order_items.each do |item|
        order = item.order
        if order.order_status == status
          merchant_orders << item
        end
      end
    end
    return merchant_orders
  end

end
