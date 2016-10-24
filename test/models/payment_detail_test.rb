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


end
