require 'test_helper'

class PaymentDetailTest < ActiveSupport::TestCase
  test "Create a PaymentDetail with valid data" do
    pay = payment_details(:one)
    pay2 = payment_details(:two)
    assert pay.valid?
    assert pay2.valid?
  end

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
    assert_includes pay.errors, :CVV
  end

  test "Email must have valid format" do
    pay1 = payment_details(:one)
    assert pay1.valid?
    pay1.email = "me_at_stupid-dotgoogledotcom"
    assert_not pay1.valid?
    assert_includes pay1.errors, :email

  end

  test "Will check for valid credit card number" do
    #TODO put test here
  end

  test "Will check if credit card number is long enough" do
    pay = PaymentDetail.new(
      order_id: 25,
      buyer_name: "Ada Lovelace",
      email: "ada@adadevacademy.com",
      street: "Fourth Avenue",
      city: "Seattle",
      state: "WA",
      zip: 12345,
      cc_four_digits: 12345,
      cc_expiration_date: "2017-10-24 13:53:49 -0700",
      time_placed: "2016-10-24 13:53:49 -0700",
      CVV: 999)
    assert_not pay.save

    assert_includes pay.errors, :cc_four_digits
    assert_includes pay.errors.get(:cc_four_digits), "Sorry, the card number must be between 13 and 16 digits"

  end

  test "Will check if credit card number is valid" do
    pay = PaymentDetail.new(
      order_id: 25,
      buyer_name: "Ada Lovelace",
      email: "ada@adadevacademy.com",
      street: "Fourth Avenue",
      city: "Seattle",
      state: "WA",
      zip: 12345,
      cc_four_digits: 1111111111111111,
      cc_expiration_date: "2017-10-24 13:53:49 -0700",
      time_placed: "2016-10-24 13:53:49 -0700",
      CVV: 999)

      assert_not pay.save
      assert_includes pay.errors, :cc_four_digits
      assert_includes pay.errors.get(:cc_four_digits), 'Sorry, an invalid cardNumber Entered'

  end

  test "Can set its own order id" do
    pay = payment_details(:one)
    pay.set_order_id(1234)
    assert_equal pay.order_id, 1234

  end

  test "Can record time payment detail was placed" do
    pay = payment_details(:two)
    pay.record_time_placed
    assert_equal pay.time_placed.day, 25
    assert_equal pay.time_placed.month, 10
    assert_equal pay.time_placed.year, 2016
  end

  test "Can set four digits of credit card number" do
    pay = PaymentDetail.new(
      order_id: 25,
      buyer_name: "DanTheMan",
      email: "ada@adadevacademy.com",
      street: "Fourth Avenue",
      city: "Seattle",
      state: "WA",
      zip: 12345,
      cc_four_digits: 4012888888881881,
      cc_expiration_date: "2017-10-24 13:53:49 -0700",
      time_placed: "2016-10-24 13:53:49 -0700",
      CVV: 999)

      assert pay.save
      assert_equal pay.cc_four_digits, 1881

  end

  test "Expiration date of credit card may not be in the past" do
    pay1 = payment_details(:one)
    pay1.cc_expiration_date = "2015-10-24 13:53:49 -0700"
    assert_not pay1.valid?
    assert_includes pay1.errors, :cc_expiration_date
  end

  test "Purchasing an order decreases the stock of each product in the order" do

    product1 = products(:product_stock1)
    product2 = products(:product_stock2)

    beginning_stock1 = product1.quantity
    beginning_stock2 = product2.quantity

    quantity_change1 = order_items(:reduce_quantity1).quantity
    quantity_change2 = order_items(:reduce_quantity2).quantity

    payment_details(:payment_card).update_products_stock("purchase")

    ending_stock1 = product1.reload.quantity
    ending_stock2 = product2.reload.quantity

    assert_equal(ending_stock1, beginning_stock1 - quantity_change1)
    assert_equal(ending_stock2, beginning_stock2 - quantity_change2)

  end

  test "Cancelling an order (after purchasing) increases the stock of each product in the order" do

    product1 = products(:product_stock1)
    product2 = products(:product_stock2)

    beginning_stock1 = product1.quantity
    beginning_stock2 = product2.quantity

    quantity_change1 = order_items(:reduce_quantity1).quantity
    quantity_change2 = order_items(:reduce_quantity2).quantity

    payment_details(:payment_card).update_products_stock("cancelation")

    ending_stock1 = product1.reload.quantity
    ending_stock2 = product2.reload.quantity

    assert_equal(ending_stock1, beginning_stock1 + quantity_change1)
    assert_equal(ending_stock2, beginning_stock2 + quantity_change2)

  end

  test "Will create a total sum for all the order items associated with an order upon purchasing" do
    # @order_items.sum_total_prices

  end


end
