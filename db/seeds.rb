# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Group.destroy_all
# Family.destroy_all
# User.destroy_all

u = User.create!(email: "val8888@hotmail.fr", password: 123456)

u.family.update!(husband_first_name: "Valentin", wife_first_name: "Marie", address: "Rue Des Champs-Élysées 1, 6181 Courcelles, Hainaut, Belgique", phone_number: "0101010101", description: "Nous sommes super sympas !", name: "MEROU")
puts "Hello"

f = Family.last
g = Group.new(family_id: f.id, name: "Groupe de garde Belgique", description: "Nous sommes un groupe de familles super sympas !", place_address: "Rue Des Champs-Élysées 1, 6181 Courcelles, Hainaut, Belgique", place_radius: 10)
g.save!
