# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

puts 'Cleaning the DB...'
Ingredient.delete_all
puts 'DB sweeped.'

puts 'Seeding ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

result = JSON.parse(open(url).read)

# p result['drinks']

result['drinks'].each do |ingredient|
  p Ingredient.create(name: ingredient['strIngredient1'])
end

puts "#{Ingredient.count} ingredients created."
