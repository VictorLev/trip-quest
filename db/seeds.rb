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



# CREATE USERS IN DATABASE
jane = User.create!(first_name: "Jane", last_name: "Doe", email: "test@example.com", password: "secret", age: 30, location: "Melbourne", gender: "female")
liam = User.create!(first_name: "Liam", last_name: "Mel", email: "liamel@gmail.com", password: "secret", age: 25, location: "Melbourne", gender: "male")
sarah = User.create!(first_name: "Sarah", last_name: "Roder", email: "sarahroder@gmail.com", password: "secret", age: 32, location: "Melbourne", gender: "female")
paul = User.create!(first_name: "Paul", last_name: "Gryn", email: "paulgrin@yahoo.com", password: "secret", age: 28, location: "Melbourne", gender: "male")
victoria = User.create!(first_name: "Victoria", last_name: "James", email: "vicjames@gmail.com", password: "secret", age: 25, location: "Melbourne", gender: "female")
james = User.create!(first_name: "James", last_name: "lord", email: "jameslord@cloud.com", password: "secret", age: 32, location: "Sydney", gender: "male")


jane_pic = URI.open("app/assets/images/jane.jpg")
jane.photo.attach(io: jane_pic, filename: "jane.jpg", content_type: "image/jpg")
jane.save!

liam_pic = URI.open("app/assets/images/liam.jpg")
liam.photo.attach(io: liam_pic, filename: "liam.jpg", content_type: "image/jpg")
liam.save!

sarah_pic = URI.open("app/assets/images/sarah.jpg")
sarah.photo.attach(io: sarah_pic, filename: "sarah.jpg", content_type: "image/jpg")
sarah.save!

paul_pic = URI.open("app/assets/images/paul.jpg")
paul.photo.attach(io: paul_pic, filename: "paul.jpg", content_type: "image/jpg")
paul.save!

victoria_pic = URI.open("app/assets/images/victoria.jpg")
victoria.photo.attach(io: victoria_pic, filename: "victoria.jpg", content_type: "image/jpg")
victoria.save!

james_pic = URI.open("app/assets/images/james.jpg")
james.photo.attach(io: james_pic, filename: "james.jpg", content_type: "image/jpg")
james.save!


# CREATE FEED IN DATABASE

  Insurer.create!(name: "Australian Seniors", min_threshold: 100 )
  Insurer.create!(name: "AWN", min_threshold: 200 )
  Insurer.create!(name: "kogan insurance", min_threshold: 300 )
  Insurer.create!(name: "AHM", min_threshold: 400 )
  Insurer.create!(name: "Youi", min_threshold: 500 )
  Insurer.create!(name: "Budget Direct", min_threshold: 600 )
  Insurer.create!(name: "Oceania insurance", min_threshold: 700 )
  Insurer.create!(name: "Allianz", min_threshold: 800 )
  Insurer.create!(name: "Medibank", min_threshold: 900 )
  Insurer.create!(name: "RACQ", min_threshold: 1000 )


# CREATE CARS IN DATABASE
car1 = Car.create!(vehicle: "Toyota Civic Sedan",
            transmission: "Manual",
            color: "White",
            year: 2010,
            kilometers: "",
            price: "500",
            insurer: Insurer.first,
            user_id: liam.id)

car2 = Car.create!(vehicle: "Mazda CX5",
              transmission: "Automatic",
              color: "Black",
              year: 2020,
              kilometers: "",
              price: "30000",
              insurer: Insurer.first,
              user_id: sarah.id)

car3 = Car.create!(vehicle: "Audi A1",
  transmission: "Automatic",
  color: "Blue",
  year: 2023,
  kilometers: "",
  price: "55000",
  insurer: Insurer.first,
  user_id: jane.id)

car4 = Car.create!(vehicle: "Renault Captur",
    transmission: "Manual",
    color: "orange",
    year: 2020,
    kilometers: "",
    price: "30000",
    insurer: Insurer.first,
    user_id: paul.id)

car4 = Car.create!(vehicle: "Toyota",
  transmission: "Manual",
  color: "grey",
  year: 2015,
  kilometers: "",
  price: "42000",
  insurer: Insurer.first,
  user_id: james.id)





# CREATE Stratigic Points IN database for the route Melbourne richmond - Sydney

StrategicPoint.create!(address: "Metropolitan Ring rd", latitude: -34.594619, longitude: 150.842759, danger: 2)
StrategicPoint.create!(address: "Murray Valley Hwy", latitude: -36.105694, longitude: 146.835505, danger: 3)
StrategicPoint.create!(address: "Remembrance Driveway", latitude: -34.696591, longitude: 150.022885, danger: 2)
StrategicPoint.create!(address: "South-Western Mtwy", latitude: -33.947363, longitude: 150.965241, danger: 4)
StrategicPoint.create!(address: "Boyd street", latitude: -37.063653, longitude: 149.891674, danger: 5)
StrategicPoint.create!(address: "Princes Hwy/1", latitude: -37.585287, longitude: 148.935202, danger: 2)
StrategicPoint.create!(address: "Princes Hwy/2", latitude: -38.109985, longitude: 146.888566, danger: 4)





# CREATE FEED IN DATABASE

Feed.create!(name: "TripQuesters")
Feed.create!(name: "Melbourne competitors")
Feed.create!(name: "General fun")

# CREATE TRIPS IN DATABASE
Trip.create!(start_point: "129-131 Acland St, St Kilda VIC 3182", end_point: "145-147 Williams Rd, Prahran VIC 3181", reward_point: "20", date: "12/03/2024", name: "Great Ocean Road", car: car1)
Trip.create!(start_point: "68 Acland St, St Kilda VIC 3182", end_point: "174 Smith St, Collingwood VIC 3066", reward_point: "5", date: "05/03/2024", name: "Wilson Promontory", car: car3)
Trip.create!(start_point: "68 Acland St, St Kilda VIC 3182", end_point: "174 Smith St, Collingwood VIC 3066", reward_point: "10", date: "07/03/2024", name: "Sorrento", car: car1)
Trip.create!(start_point: "68 Acland St, St Kilda VIC 3182", end_point: "174 Smith St, Collingwood VIC 3066", reward_point: "2", date: "013/03/2024", name: "Philip island", car: car2)
Trip.create!(start_point: "68 Acland St, St Kilda VIC 3182", end_point: "174 Smith St, Collingwood VIC 3066", reward_point: "2", date: "013/03/2024", name: "Philip island", car: car4)
Trip.create!(start_point: "68 Acland St, St Kilda VIC 3182", end_point: "174 Smith St, Collingwood VIC 3066", reward_point: "2", date: "013/03/2024", name: "Philip island", car: car2)



Trip.all.each do |trip|
  create_strategic_points_for_trip(trip)
end

journey_pic = URI.open("app/assets/images/journey_1.jpg")
Trip.first.photo.attach(io: journey_pic, filename: "journey_1.jpg", content_type: "image/jpg")
Trip.first.save!
