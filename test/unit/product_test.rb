require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = Product.new(
      title: "My Book",
      description: "This is a really good book.",
      image_url: "zzz.jpg"
    )
    
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 1
    assert product.valid?
  end
  
  test "product img url must be valid" do
    ok = ["img1.jpg", "img2.JpG"]
    bad = ["hmm.doc", "trala.rb", "test.jpg\nkasper"]
    
    ok.each do |img|
      product = Product.new(
        title: "Test book",
        description: "This is a book used for testing.",
        price: 1,
        image_url: img
      )
      
      assert product.valid?, "#{img} should be valid."
    end
    
    bad.each do |img|
      product = Product.new(
        title: "Test book",
        description: "This is a book used for testing.",
        price: 1,
        image_url: img
      )
      
      assert product.invalid?, "#{img} should be invalid."
    end
  end
  
  test "product is not valid without a unique title" do
    product = Product.new(
      title: products(:ruby).title,
      description: "Test unique title product.",
      price: 1,
      image_url: "test.jpg"
    )
    
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
  
  test "product title must be a minimum of 5 characters and a maximum of 50" do
    product = Product.new(
      title: "abc",
      description: "Test minimum title length.",
      price: 1,
      image_url: "test.jpg"
    )
    
    assert product.invalid?
    assert_equal ["is too short (minimum is 5 characters)"], product.errors[:title]
    
    product = Product.new(
      title: "a" * 51,
      description: "Test maximum title length",
      price: 1,
      image_url: "test.jpg"
    )
    
    assert product.invalid?
    assert_equal ["is too long (maximum is 50 characters)"], product.errors[:title]
  end
  
  test "it should not be possible to sell the author of this app (test validate-callback to method)" do
    product = Product.new(
      title: "Kasper Johansen",
      description: "Test sell author",
      price: 1,
      image_url: "test.jpg"
    )
    
    assert product.invalid?
    assert_equal ["Don't sell the author of this program!"], product.errors[:title]
  end
end
