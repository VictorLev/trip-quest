# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def create_strategic_points_for_trip(trip)
  StrategicPoint.all.shuffle.first(4).each do |sp|
    # Create the joiner
    ActualReward.create!(trip: trip, strategic_point: sp)
  end
end

require 'faker'

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
