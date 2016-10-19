require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "Create a Product with valid data" do
    product = products(:one)
    assert product.valid?
  end

  test "Product must have a name" do
    product = Product.new(price: 2)
    assert_not product.valid?
    assert_includes product.errors, :name
  end

  test "Name must be unique" do
    product1 = products(:one)
    product2 = Product.new(name: "broomstick", price: 2)

    assert_not product2.valid?
  end

  test "Product must have a price" do
    product = products(:two)
    assert product.valid?
    assert_equal product.price, 13.52
    product1 = Product.new(name: "Test product")
    assert_not product1.valid?
  end

  test "Prices can be the same" do
    product1 = products(:two)
    product2 = products(:three)
    assert_equal product1.price, product2.price
    assert product1.valid?
    assert product2.valid?
  end

  test "Price must be a float" do
    product = products(:two)
    assert_equal product.price.class, Float
  end

  test "Price must be greater than zero" do
    product1 = Product.new(name: "bad price", price: 0)
    product2 = Product.new(name: "another bad price", price: -2.1)
    procuct3 = products(:one)
    assert_not product1.valid?
    assert_not product2.valid?
    assert procuct3.valid?
  end

end
