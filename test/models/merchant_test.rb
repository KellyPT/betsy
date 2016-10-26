require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "Create a Merchant with valid data" do
    merchant = merchants(:one)
    assert merchant.valid?
  end

  test "Merchant must have an email, uid, and provider" do
    merchant = Merchant.new
    assert_not merchant.valid?

    assert_includes merchant.errors, :email
    assert_includes merchant.errors, :uid
    assert_includes merchant.errors, :provider
  end

  test "get_merchant_orders will return an array of all order items associated with that merchant" do
    merchant = merchants(:merchant_with_orders)

    orders = merchant.get_merchant_orders
    assert_kind_of  Array, orders
    # assert_includes orders, order_items(:reduce_quantity1)
    # assert_includes orders, order_items(:reduce_quantity2)

  end

end
