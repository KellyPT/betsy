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

  test "Rating should be a number between 1 and 5" do
    review1 = Review.new(rating: 0)
    review2 = Review.new(rating: 6)
    review3 = reviews(:one)
    review4 = reviews(:two)
    assert_not review1.valid?
    assert_not review2.valid?
    assert review3.valid?
    assert review4.valid?

    assert_includes product1.errors, :rating
    assert_includes product2.errors, :rating
  end
  
end
