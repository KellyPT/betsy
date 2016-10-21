class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  has_one :PaymentDetail

  def self.build_order
      order          = self.new
      order.order_status  = "pending"

    return order
  end

  def mark_order_paid
    self.order_status = "paid"
    return self
  end

  def cancel_order
    self.order_status = "cancelled"
    return self
  end

end
