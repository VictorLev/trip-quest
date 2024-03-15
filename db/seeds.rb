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


def create_strategic_points_for_trip(trip)
  StrategicPoint.all.shuffle.first(1).each do |sp|
    # Create the joiner
    ActualReward.create!(trip: trip, strategic_point: sp)
  end
end


#  DESTROY ALL OBJECTS IN DATABASE
User.destroy_all
Car.destroy_all
Feed.destroy_all
Insurer.destroy_all
Trip.destroy_all
StrategicPoint.destroy_all


# Function to generate random coordinates within Melbourne
def generate_random_coordinates
  melbourne_latitude = -37.7736
  melbourne_longitude = 144.9631
  latitude_variation = 0.05
  longitude_variation = 0.05

  random_latitude = melbourne_latitude + rand(-latitude_variation..latitude_variation)
  random_longitude = melbourne_longitude + rand(-longitude_variation..longitude_variation)

  [random_latitude, random_longitude]
end


# CREATE USERS IN DATABASE
jane = User.create!(first_name: "Jane", last_name: "Doe", email: "test@example.com", password: "secret", age: 30, location: "Melbourne", gender: "female")
liam = User.create!(first_name: "Liam", last_name: "Mel", email: "liamel@gmail.com", password: "secret", age: 25, location: "Melbourne", gender: "male")
sarah = User.create!(first_name: "Sarah", last_name: "Roder", email: "sarahroder@gmail.com", password: "secret", age: 32, location: "Melbourne", gender: "female")
victor = User.create!(first_name: "Victor", last_name: "Levesque", email: "vic@gmail.com", password: "secret", age: 21, location: "Melbourne", gender: "male")
emma = User.create!(first_name: "Emma", last_name: "Stone", email: "emma@gmail.com", password: "secret", age: 19, location: "Melbourne", gender: "female")
jaco = User.create!(first_name: "Jaco", last_name: "Riani", email: "jaco@gmail.com", password: "secret", age: 32, location: "Melbourne", gender: "male")
mehul = User.create!(first_name: "Mehul", last_name: "Mehul", email: "mehul@gmail.com", password: "secret", age: 25, location: "Melbourne", gender: "male")

mehul_pic = URI.open("app/assets/images/mehul.png")
mehul.photo.attach(io: mehul_pic, filename: "mehul.png", content_type: "image/png")
mehul.save!

jaco_pic = URI.open("app/assets/images/jaco.png")
jaco.photo.attach(io: jaco_pic, filename: "jaco.png", content_type: "image/png")
jaco.save!

victor_pic = URI.open("app/assets/images/vic.jpg")
victor.photo.attach(io: victor_pic, filename: "vic.jpg", content_type: "image/jpg")
victor.save!

emma_pic = URI.open("app/assets/images/emma.jpg")
emma.photo.attach(io: emma_pic, filename: "emma.jpg", content_type: "image/jpg")
emma.save!


# CREATE FEED IN DATABASE
num = 0
10.times do
  Insurer.create!(name: Faker::Company.name, min_threshold: num )
  num += 100
end

# CREATE CARS IN DATABASE
car1 = Car.create!(vehicle: "Toyota Civic Sedan",
            transmission: "Manual",
            color: "White",
            year: 2010,
            kilometers: "",
            price: "500",
            insurer: Insurer.first,
            user_id: jane.id)

car2 = Car.create!(vehicle: "Mazda CX5",
              transmission: "Automatic",
              color: "Black",
              year: 2020,
              kilometers: "",
              price: "30000",
              insurer: Insurer.first,
              user_id: jane.id)


# CREATE RANDOM Stratigic Points IN database with random coordinates
10.times do
  latitude, longitude = generate_random_coordinates
  address = Faker::Address
  StrategicPoint.create!(address: address.city, latitude: latitude, longitude: longitude, danger: rand(1..5))
end


# CREATE FEED IN DATABASE

Feed.create!(name: "TripQuesters")
Feed.create!(name: "Melbourne competitors")
Feed.create!(name: "General fun")

# CREATE TRIPS IN DATABASE
Trip.create!(start_point: "129-131 Acland St, St Kilda VIC 3182", end_point: "145-147 Williams Rd, Prahran VIC 3181", reward_point: "20", date: "12/03/2024", name: "Great Ocean Road", car: car1)
Trip.create!(start_point: "68 Acland St, St Kilda VIC 3182", end_point: "174 Smith St, Collingwood VIC 3066", reward_point: "5", date: "05/03/2024", name: "Wilson Promontory", car: car1)
Trip.create!(start_point: "68 Acland St, St Kilda VIC 3182", end_point: "174 Smith St, Collingwood VIC 3066", reward_point: "10", date: "07/03/2024", name: "Sorrento", car: car1)
Trip.create!(start_point: "68 Acland St, St Kilda VIC 3182", end_point: "174 Smith St, Collingwood VIC 3066", reward_point: "2", date: "013/03/2024", name: "Philip island", car: car2)

Trip.all.each do |trip|
  create_strategic_points_for_trip(trip)
end

journey_pic = URI.open("app/assets/images/journey_1.jpg")
Trip.first.photo.attach(io: journey_pic, filename: "journey_1.jpg", content_type: "image/jpg")
Trip.first.save!
