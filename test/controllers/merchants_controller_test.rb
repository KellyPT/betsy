require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase
  # setup do
  #   @merchant = merchants(:one)
  # end

  test "should get index" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should show merchant" do
    merchant_id = merchants(:one).id
    get :show, { id: merchant_id }
    assert_response :success
    assert_template :show
  end

  test "should show the requested merchant" do
    merchant_id = merchants(:one).id
    get :show, { id: merchant_id }
    assert_response :success
    assert_template :show
    assert_equal assigns(:merchant), merchants(:one)
  end

end
