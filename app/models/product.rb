class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  
  validates :title, :description, :image_url, presence: true, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :image_url, uniqueness: true, allow_blank: true, format: {with: /\.(gif|jpg|png)\Z/i, message: "Must be a valid image (GIF, JPG or PNG)"}
end
