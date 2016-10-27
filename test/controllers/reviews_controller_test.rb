require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:one)
  end

  # test "should get index" do
  #   get :index, {product_id: @review.product.id}
  #   assert_response :success
  #   assert_template :index
  # end

  test "should get new" do

    get :new, product_id: reviews(:one).product_id

    assert_response :success
    # review = assigns(:review)
    # assert_not_nil(review)

  end
  # test "should create review" do
  #   assert_difference('Review.count') do
  #     post reviews_url, params: { review: {  } }
  #   end
  #
  #   assert_redirected_to review_url(Review.last)
  # end
  #
  # test "should show review" do
  #   get review_url(@review)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_review_url(@review)
  #   assert_response :success
  # end
  #
  # test "should update review" do
  #   patch review_url(@review), params: { review: {  } }
  #   assert_redirected_to review_url(@review)
  # end
  #
  # test "should destroy review" do
  #   assert_difference('Review.count', -1) do
  #     delete review_url(@review)
  #   end
  #
  #   assert_redirected_to reviews_url
  # end
end
