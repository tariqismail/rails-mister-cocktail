# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

# Clear the DB

puts 'Cleaning the DB...'
Dose.delete_all
Cocktail.delete_all
Ingredient.delete_all
puts 'DB sweeped.'

# Seed Ingredients

puts 'Seeding ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

result = JSON.parse(open(url).read)

# p result['drinks']

result['drinks'].each do |ingredient|
  name = ingredient['strIngredient1']
  Ingredient.create(name: name)
  # image_uri = "https://www.thecocktaildb.com/images/ingredients/#{name.gsub(' ', '%20')}-Medium.png"
  # file = URI.open(image_uri)
  # ingredient.photo.attach(io: file, filename: "#{name}.png", content_type: 'image/png')
end

puts "#{Ingredient.count} ingredients created."

# Seed Mocktails

puts "Seeding mocktails..."

# Get list of mocktails

url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic'

result = JSON.parse(open(url).read)

result['drinks'].each do |drink|
  name = drink['strDrink']
  cocktail = Cocktail.new(name: name)
  # Get the cocktail image from the API
  file = URI.open(drink['strDrinkThumb'])
  cocktail.photo.attach(io: file, filename: "#{name}.png", content_type: 'image/png')
  cocktail.save

  # created doses for each drink
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink['idDrink']}"
  drink_result = JSON.parse(open(url).read)
  details = drink_result['drinks'].first
  (1..15).each do |index|
    key_ingredient = "strIngredient#{index}"
    key_dose = "strMeasure#{index}"
    details[key_ingredient]
    unless details[key_ingredient].nil?
      ingredient = Ingredient.find_by(name: details[key_ingredient])
      dose = Dose.new(description: details[key_dose])
      dose.ingredient = ingredient
      dose.cocktail = cocktail
      dose.save
    end
  end
end

puts "#{Cocktail.count} moktails created."

# https://www.thecocktaildb.com/images/ingredients/gin-Small.png
