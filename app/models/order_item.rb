class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def self.build_order_item(this_order_id, this_product_id)
    order_item = self.new
    order_item.order_id = this_order_id
    order_item.product_id = this_product_id
    order_item.quantity = 1
    return order_item
  end
end
