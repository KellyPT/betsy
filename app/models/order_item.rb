class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: {greater_than: 0}

  def self.add_order_item_to_order(this_order_id, this_product_id)
    order_item = self.new(quantity: 1)
    order_item.order_id = this_order_id
    order_item.product_id = this_product_id
    # order_item.quantity = 1
    return order_item
  end
end
