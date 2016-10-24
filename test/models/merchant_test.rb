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
end
