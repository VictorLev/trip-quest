# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

#  DESTROY ALL OBJECTS IN DATABASE
User.destroy_all
Feed.destroy_all



# CREATE USERS IN DATABASE

User.create!(first_name: "Emma", last_name: "Stone", email: "emmastone@gmail.com", password: "secret", age: 30, location: "Melbourne", gender: "female")
User.create!(first_name: "Victor", last_name: "Levesque", email: "victorlevesque@gmail.com", password: "secret", age: 30, location: "Melbourne", gender: "male")
User.create!(first_name: "Mehul", last_name: "Natarajan", email: "Mehulnatarajan@gmail.com", password: "secret", age: 30, location: "Melbourne", gender: "male")
User.create!(first_name: "Jacopo", last_name: "Riani", email: "jacoporiani@gmail.com", password: "secret", age: 30, location: "Melbourne", gender: "male")

# CREATE FEED IN DATABASE
num = 0
10.times do
  Insurer.create!(name: Faker::Company.name, min_threshold: num )
  num += 100
end

# CREATE FEED IN DATABASE

Feed.create!(name: "TripQuesters")
Feed.create!(name: "Melbourne competitors")
Feed.create!(name: "General fun")
