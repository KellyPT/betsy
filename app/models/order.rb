class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment_detail

  validates :order_status, presence: true
  # TODO: only allow certain pre-defined statuses

  def self.build_order
    return self.new(order_status: "pending")
  end

  def mark_order_paid
    self.order_status = "paid"
    return self
  end

  def cancel_order
    self.order_status = "cancelled"
    return self
  end

  def complete_order
    self.order_status = "completed"
    return self
  end

end
