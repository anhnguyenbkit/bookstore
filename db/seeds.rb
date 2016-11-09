# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach(Rails.root.join("db/seeds_data/books.csv"), headers: true) do |row|
  Book.find_or_create_by(typeBook: row[0], category: row[1], price: row[2], name: row[3], author: row[4], isbn: row[5], pages: row[6], publisher: row[7], poster_url: row[8])
end
