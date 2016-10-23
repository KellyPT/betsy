require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # t.integer  "product_id"
  # t.integer  "rating"
  # t.string   "description"

  test "Create a Review with valid data" do
    review = reviews(:one)
    assert review.valid?
  end

  test "Rating cannot be less than 1" do
    review = Review.new(rating: 0)
    assert_not review.valid?
  end
end
