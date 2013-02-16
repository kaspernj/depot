# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all

Product.create(
  :title => "Programming Ruby 1.9",
  :description =>  %{
    <p>
      Ruby is a nice and expresive language.
    </p>
  },
  :image_url => "ruby.jpg",
  :price => 49.95
)

Product.create(
  :title => "CoffeeScript",
  :description => %{
    CoffeeScript is also a nice language.
  },
  :image_url => "cs.jpg",
  :price => 35.4
)

Product.create(
  :title => "Rails Test Prescriptions",
  :description => %{
    Keeping Your Application Healthy
  },
  :image_url => "rtp.jpg",
  :price => 39.5
)