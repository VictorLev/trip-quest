# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
User.create!(first_name: "Emma", last_name: "Stone", email: "emmastone@gmail.com", password: "secret", age: 30, location: "Melbourne", gender: "female")
User.create!(first_name: "Victor", last_name: "Levesque", email: "victorilevesque@gmail.com", password: "secret", age: 30, location: "Melbourne", gender: "male")
User.create!(first_name: "Mehul", last_name: "Natarajan", email: "Mehulnatarajan@gmail.com", password: "secret", age: 30, location: "Melbourne", gender: "male")
User.create!(first_name: "Jacopo", last_name: "Riani", email: "jacoporiani@gmail.com", password: "secret", age: 30, location: "Melbourne", gender: "male")


Feed.destroy_all
Feed.create!(name: "General fun")
Feed.create!(name: "Melbourne competitors")
Feed.create!(name: "TripQuesters")
