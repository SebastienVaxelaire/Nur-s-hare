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

u = User.create(email: "val@hotmail.fr", password: 123456)
f = u.family
f.update(husband_first_name: "Valentin", wife_first_name: "Marie", address: "Rue Des Champs-Élysées 1, 6181 Courcelles, Hainaut, Belgique", phone_number: "0101010101", description: "Nous sommes super sympas !", name: "MEROU")

u2 = User.create(email: "wadi@hotmail.fr", password: 123456)
f2 = u2.family
f2.update(husband_first_name: "wadi", wife_first_name: "Marie", address: "5 Rue Anatole France, 57100 La Louvière, Belgique", phone_number: "0101010101", description: "Nous sommes super sympas !", name: "WADI")
Group.create(family: f2, name: "Groupe de garde Belgique", description: "Nous sommes un groupe de familles super sympas !", place_address: "5 Rue Anatole France, 57100 La Louvière, Belgique", place_radius: 10)
