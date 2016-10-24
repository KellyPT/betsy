require 'test_helper'

class PaymentDetailTest < ActiveSupport::TestCase
  # test "Create a PaymentDetail with valid data" do
  #   pay = payment_details(:one)
  #   assert pay.valid?
  # end

  test "Must have a buyer name, street, city, zip, credit card information and time of order" do
    pay = PaymentDetail.new
    assert_not pay.valid?
    assert_includes pay.errors, :buyer_name
    assert_includes pay.errors, :street
    assert_includes pay.errors, :city
    assert_includes pay.errors, :zip
    assert_includes pay.errors, :cc_four_digits
    assert_includes pay.errors, :cc_expiration_date
    assert_includes pay.errors, :time_placed
  end

  test "Email must have valid format" do
    #TODO put test here
  end

  test "Will check for valid credit card number" do
    #TODO put test here
  end

  test "Will check if credit card number is long enough" do
    #TODO put test here
  end

  test "Can set its own order id" do
    #TODO put test here
  end

  test "Can record time payment detail was placed" do

  end

  test "Can set four digits of credit card number" do
    #TODO put test here
  end

  test "Expiration date of credit card may not be in the past" do
    #TODO put test here

  end

  test "Purchasing an order updates the stock of each product in the order" do

    product1 = products(:product_stock1)
    product2 = products(:product_stock2)

    beginning_stock1 = product1.quantity
    beginning_stock2 = product2.quantity

    quantity_change1 = order_items(:reduce_quantity1).quantity
    quantity_change2 = order_items(:reduce_quantity2).quantity

    payment_details(:payment_card).update_products_stock

    ending_stock1 = product1.reload.quantity
    ending_stock2 = product2.reload.quantity

    assert_equal(ending_stock1, beginning_stock1 - quantity_change1)
    assert_equal(ending_stock2, beginning_stock2 - quantity_change2)

  end


end
