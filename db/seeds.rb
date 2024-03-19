# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


#  DESTROY ALL OBJECTS IN DATABASE
puts "Deleting users..."
User.destroy_all
puts "Deleting cars..."
Car.destroy_all
puts "Deleting feed..."
Feed.destroy_all
puts "Deleting insurers..."
Insurer.destroy_all
puts "Deleting trips..."
Trip.destroy_all
puts "Deleting points..."
StrategicPoint.destroy_all


puts "Creating users..."
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

puts "Creating insurers..."
# CREATE FEED IN DATABASE

  Insurer.create!(name: "Australian Seniors", min_threshold: 100, discount: 10)
  Insurer.create!(name: "AWN", min_threshold: 200, discount: 10 )
  Insurer.create!(name: "kogan insurance", min_threshold: 300, discount: 10)
  Insurer.create!(name: "AHM", min_threshold: 400, discount: 10 )
  Insurer.create!(name: "Youi", min_threshold: 500, discount: 10 )
  Insurer.create!(name: "Budget Direct", min_threshold: 600, discount: 10 )
  Insurer.create!(name: "Oceania insurance", min_threshold: 700, discount: 10 )
  Insurer.create!(name: "Allianz", min_threshold: 800, discount: 10 )
  Insurer.create!(name: "Medibank", min_threshold: 900, discount: 10 )
  Insurer.create!(name: "RACQ", min_threshold: 1000, discount: 10 )

  puts "Creating cars..."
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
  insurer: Insurer.second,
  user_id: jane.id)

car4 = Car.create!(vehicle: "Renault Captur",
    transmission: "Manual",
    color: "orange",
    year: 2020,
    kilometers: "",
    price: "30000",
    insurer: Insurer.third,
    user_id: paul.id)

car5 = Car.create!(vehicle: "Toyota",
  transmission: "Manual",
  color: "grey",
  year: 2015,
  kilometers: "",
  price: "42000",
  insurer: Insurer.fourth,
  user_id: jane.id)



# CREATE Stratigic Points IN database for the route Melbourne richmond - Sydney
puts "Creating points..."
sp1 = StrategicPoint.create!(address: "Metropolitan Ring rd", latitude: -34.594619, longitude: 150.842759, danger: 2)
sp2 = StrategicPoint.create!(address: "Murray Valley Hwy", latitude: -36.105694, longitude: 146.835505, danger: 3)
sp3 = StrategicPoint.create!(address: "Remembrance Driveway", latitude: -34.696591, longitude: 150.022885, danger: 2)
sp4 = StrategicPoint.create!(address: "South-Western Mtwy", latitude: -33.947363, longitude: 150.965241, danger: 4)
sp5 = StrategicPoint.create!(address: "Boyd street", latitude: -37.063653, longitude: 149.891674, danger: 5)
sp6 = StrategicPoint.create!(address: "Princes Hwy/1", latitude: -37.585287, longitude: 148.935202, danger: 2)
sp7 = StrategicPoint.create!(address: "Princes Hwy/2", latitude: -38.109985, longitude: 146.888566, danger: 4)
sp8 = StrategicPoint.create!(address: "Great ocean Road", latitude: -38.426227, longitude: 144.168440, danger: 4)
sp9 = StrategicPoint.create!(address: "Nepean Hwy", latitude: -38.101590, longitude: 145.125872, danger: 4)



# CREATE FEED IN DATABASE
puts "Creating feed..."
Feed.create!(name: "TripQuesters")
Feed.create!(name: "Melbourne competitors")
Feed.create!(name: "General fun")

# CREATE TRIPS IN DATABASE
puts "Creating trips..."
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864, 143.430955", reward_point: "20", date: "12/03/2024", name: "Great Ocean Road", car: car1)
wp = Trip.create!(start_point: "-37.826034, 145.001111", end_point: "-38.916750, 146.380524", reward_point: "5", date: "05/03/2024", name: "Wilson Promontory", car: car3)
sorrento = Trip.create!(start_point: "-37.798496, 144.979754", end_point: "-38.337904, 144.743811", reward_point: "10", date: "07/03/2024", name: "Sorrento", car: car5)
pi = Trip.create!(start_point: "-37.798665, 144.987446", end_point: "-38.490159, 145.201303", reward_point: "2", date: "28/02/2024", name: "Philip island", car: car3)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497, 144.321543", reward_point: "2", date: "10/03/2024", name: "Torquay", car: car3)
og = Trip.create!(start_point: "-37.809397, 145.078092", end_point: "-38.236541, 144.521061", reward_point: "2", date: "21/03/2024", name: "Ocean grove", car: car5)
bend = Trip.create!(start_point: "-37.690937, 145.078092", end_point: "-36.740942, 144.292652", reward_point: "2", date: "12/03/2024", name: "Bendigo", car: car4)
epping = Trip.create!(start_point: "-37.809397, 145.078092", end_point: "-37.649890, 145.023161", reward_point: "2", date: "21/03/2024", name: "Ocean grove", car: car5)
ballarat = Trip.create!(start_point: "-37.690937, 145.078092", end_point: "-37.547523, 143.850102", reward_point: "2", date: "12/03/2024", name: "Bendigo", car: car2)



ActualReward.create!(trip: gor, strategic_point: sp8)
ActualReward.create!(trip: wp, strategic_point: sp9)
ActualReward.create!(trip: sorrento, strategic_point: sp9)
ActualReward.create!(trip: pi, strategic_point: sp9)
ActualReward.create!(trip: torq, strategic_point: sp8)
ActualReward.create!(trip: og, strategic_point: sp9)
ActualReward.create!(trip: bend, strategic_point: sp1)

journey_pic = URI.open("app/assets/images/journey_1.jpg")
Trip.first.photo.attach(io: journey_pic, filename: "journey_1.jpg", content_type: "image/jpg")
Trip.first.save!

wp_pic = URI.open("app/assets/images/wilsons_prom.png")
wp.photo.attach(io: wp_pic, filename: "wilsons_prom.png", content_type: "image/png")
wp.save!

sor_pic = URI.open("app/assets/images/sorrento.png")
sorrento.photo.attach(io: sor_pic, filename: "sorrento.png", content_type: "image/png")
sorrento.save!

phil_pic = URI.open("app/assets/images/phillip_island.png")
pi.photo.attach(io: phil_pic, filename: "phillip_island.png", content_type: "image/png")
pi.save!

puts "Done!"
