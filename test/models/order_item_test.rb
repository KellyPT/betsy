require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "Create an OrderItem with valid data" do
    order_item = order_items(:one)
    assert order_item.valid?
  end

  test "Must have positive quantity" do
    order_item1 = order_items(:one)
    order_item2 = OrderItem.new(quantity: -4)
    assert order_item1.valid?
    assert_not order_item2.valid?

    assert_includes order_item2.errors, :quantity

  end

  test "Will create a total sum for all the order items associated with an order group" do
    # @order_items.sum_total_prices
      order = orders(:purchasing_order)
      order_items_group = order.order_items

      method_sum = OrderItem.sum_total_prices(order_items_group)

      product1 = products(:product_stock1)
      product2 = products(:product_stock2)

      quantity1 = order_items(:reduce_quantity1).quantity
      quantity2 = order_items(:reduce_quantity2).quantity

      sub_total1 = product1.price * quantity1
      sub_total2 = product2.price * quantity2

      assert_equal(method_sum, sub_total1 + sub_total2)
  end

end
