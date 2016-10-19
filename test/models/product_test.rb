require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "Create a Product with valid data" do
    product = products(:one)
    puts "HELLO HERE IS THE PRODUCT#{product.quantity}"
    assert product.valid?
  end
end

# test "Create an album with valid data" do
#     album = albums(:one)
#     assert album.valid?
#   end
#
#   test "Cannot create an unnamed album" do
#     album = Album.new
#     assert_not album.valid?
#     assert_includes album.errors, :title
#
#   end
