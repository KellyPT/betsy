class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def add_item(order_item)
    if order_item.quantity
      order_item.quantity += 1
    else
      false
    end
  end

  # subtract an item from the quantity if able
  # else returns false
  def remove_item(order_item)
    if order_item.quantity > 0
      order_item.quantity -= 1
    else
      false
    end
  end

# display order item method that shows only if order items are > 0?
end
