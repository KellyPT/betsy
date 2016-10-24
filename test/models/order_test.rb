require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "Create an Order with valid data" do
    order = orders(:one)
    assert order.valid?
  end

  test "Order must have a status of pending, paid, or cancelled" do
    order1 = orders(:one)
    order2 = orders(:two)
    order3 = orders(:three)
    # order4 = Order.new(order_status: "I have no valid status")
    order5 = Order.new
    order6 = orders(:three)


    assert order1.valid?
    assert order2.valid?
    assert order3.valid?
    # assert_not order4.valid?
    assert_not order5.valid?
    assert order6.valid?
    #
    # assert_includes order4.errors, :order_status
    assert_includes order5.errors, :order_status
  end

  test "Can mark itself as paid" do
    order = orders(:one)
    assert_equal order.order_status, "pending"
    order.mark_order_paid
    assert_equal order.order_status, "paid"
  end

  test "Can set status to cancelled" do
    order = orders(:one)
    assert_equal order.order_status, "pending"
    order.cancel_order
    assert_equal order.order_status, "cancelled"
  end

  test "Can set status to complete" do
    order = orders(:one)
    assert_equal order.order_status, "pending"
    order.complete_order
    assert_equal order.order_status, "completed"
  end
end
