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
end
