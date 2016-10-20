class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  has_one :PaymentDetail

  def self.build_order
      order          = self.new
      order.order_status  = "pending"

    return order
  end

  def purchase_order
    order.order_status    = "paid"
    order.time_place = Time.now
  end

  def cancel_order
    order.order_status  = "cancelled"
  end

end
