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

  # TODO: cannot test Class method in Model tests, or can I? not sure

end
