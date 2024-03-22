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
jaco = User.create!(first_name: "Jacopo", last_name: "Riani", email: "jack@riani.com", password: "secret", age: 30, location: "Melbourne", gender: "female")
liam = User.create!(first_name: "Liam", last_name: "Mel", email: "liamel@gmail.com", password: "secret", age: 25, location: "Melbourne", gender: "male")
sarah = User.create!(first_name: "Sarah", last_name: "Roder", email: "sarahroder@gmail.com", password: "secret", age: 32, location: "Melbourne", gender: "female")
paul = User.create!(first_name: "Paul", last_name: "Gryn", email: "paulgrin@yahoo.com", password: "secret", age: 28, location: "Melbourne", gender: "male")
victoria = User.create!(first_name: "Victoria", last_name: "James", email: "vicjames@gmail.com", password: "secret", age: 25, location: "Melbourne", gender: "female")
james = User.create!(first_name: "James", last_name: "lord", email: "jameslord@cloud.com", password: "secret", age: 32, location: "Sydney", gender: "male")

jaco_pic = URI.open("app/assets/images/jaco.jpg")
jaco.photo.attach(io: jaco_pic, filename: "jaco.jpg", content_type: "image/jpg")
jaco.save!

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

toyota = URI.open("app/assets/images/car.jpg")
car1.photo.attach(io: toyota, filename: "car.jg", content_type: "image/jpg")
car1.save!

car2 = Car.create!(vehicle: "Mazda CX5",
            transmission: "Automatic",
            color: "Black",
            year: 2020,
            kilometers: "",
            price: "30000",
            insurer: Insurer.first,
            user_id: sarah.id)

mazda = URI.open("app/assets/images/mazda.jpg")
car2.photo.attach(io: mazda, filename: "mazda.jpg", content_type: "image/jpg")
car2.save!

car3 = Car.create!(vehicle: "Audi A1",
            transmission: "Automatic",
            color: "Blue",
            year: 2023,
            kilometers: "",
            price: "55000",
            insurer: Insurer.second,
            user_id: jaco.id)

audiA1 = URI.open("app/assets/images/audiA1.jpg")
car3.photo.attach(io: audiA1, filename: "audiA1.jpg", content_type: "image/jpg")
car3.save!

car4 = Car.create!(vehicle: "Renault Captur",
            transmission: "Manual",
            color: "orange",
            year: 2020,
            kilometers: "",
            price: "30000",
            insurer: Insurer.third,
            user_id: paul.id)

renault = URI.open("app/assets/images/renault.jpg")
car4.photo.attach(io: renault, filename: "renault.jpg", content_type: "image/jpg")
car4.save!

car5 = Car.create!(vehicle: "Toyota SUV",
            transmission: "Manual",
            color: "grey",
            year: 2015,
            kilometers: "",
            price: "42000",
            insurer: Insurer.fourth,
            user_id: jaco.id)

toyotasuv = URI.open("app/assets/images/toyota.jpeg")
car5.photo.attach(io: toyotasuv, filename: "toyota.jpeg", content_type: "image/jpeg")
car5.save!

car6 = Car.create!(vehicle: "Jeep",
  transmission: "Manual",
  color: "grey",
  year: 2022,
  kilometers: "",
  price: "42000",
  insurer: Insurer.fourth,
  user_id: victoria.id)

jeep = URI.open("app/assets/images/jeep.jpg")
car6.photo.attach(io: jeep, filename: "jeep.jpg", content_type: "image/jpg")
car6.save!

car7 = Car.create!(vehicle: "Ford",
  transmission: "Manual",
  color: "white",
  year: 2022,
  kilometers: "",
  price: "12000",
  insurer: Insurer.fourth,
  user_id: james.id)

ford = URI.open("app/assets/images/ford.jpg")
car7.photo.attach(io: ford, filename: "ford.jpg", content_type: "image/jpg")
car7.save!

# CREATE FEED IN DATABASE
puts "Creating feed..."
Feed.create!(name: "TripQuesters")
Feed.create!(name: "Melbourne competitors")
Feed.create!(name: "General fun")


# CREATE Stratigic Points IN database for the route Melbourne richmond - Sydney
puts "Creating points..."
sp1 = StrategicPoint.create!(address: "Metropolitan Ring rd", latitude: -34.594619, longitude: 150.842759, danger: 350)
sp2 = StrategicPoint.create!(address: "Princes Hwy", latitude: -34.526374, longitude: 150.787291, danger: 450)
sp3 = StrategicPoint.create!(address: "Remembrance Driveway", latitude: -34.671288, longitude: 150.138278, danger: 200)
sp4 = StrategicPoint.create!(address: "South-Western Mtwy", latitude: -33.947363, longitude: 150.965241, danger: 50)
sp5 = StrategicPoint.create!(address: "Boyd street", latitude: -37.063653, longitude: 149.891674, danger: 250)
sp6 = StrategicPoint.create!(address: "Princes Hwy/1", latitude: -37.585287, longitude: 148.935202, danger: 150)
sp7 = StrategicPoint.create!(address: "Princes Hwy/2", latitude: -38.109985, longitude: 146.888566, danger: 200)
sp8 = StrategicPoint.create!(address: "Great ocean Road", latitude: -38.426227, longitude: 144.168440, danger: 250)
sp9 = StrategicPoint.create!(address: "Nepean Hwy", latitude: -38.101590, longitude: 145.125872, danger: 200)
sp10 = StrategicPoint.create!(address: "Ballarat", latitude: -37.553680, longitude: 143.913014, danger: 150)
sp11 = StrategicPoint.create!(address: "Princes Fwy", latitude: -38.027610, longitude: 144.437139, danger: 50)
sp12 = StrategicPoint.create!(address: "Boldrewood Parade", latitude: -37.723209, longitude: 145.022404, danger: 150)
sp13 = StrategicPoint.create!(address: "Geelong road", latitude: -37.774894, longitude: 145.064744, danger: 150)


# CREATE TRIPS IN DATABASE
puts "Creating trips..."
gor = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car5)
wp = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.916750,146.380524", reward_point: sp9.danger, date: "05/03/2024", name: "Wilson Promontory", car: car3)
sorrento = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "02/01/2024", name: "Sorrento", car: car5)
pi = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "09/03/2024", name: "Philip Island", car: car3)
torq = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/12/2023", name: "Torquay", car: car3)
og = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.236541,144.521061", reward_point: sp11.danger, date: "02/03/2024", name: "Ocean Grove", car: car5)
bend = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-36.740942,144.292652",  reward_point: sp12.danger, date: "30/01/2024", name: "Bendigo", car: car3)
epping = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-37.649890,145.023161", reward_point: sp12.danger, date: "29/02/2024", name: "Epping", car: car5)
ballarat = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-37.547523,143.850102", reward_point: sp10.danger, date: "12/02/2024", name: "Ballarat", car: car5)
sydney = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "05/02/2024", name: "Sydney", car: car5)
drysdale = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car3)
wollongong = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/12/2023", name: "Wollongong", car: car5)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car6)
ballarat = Trip.create!(start_point: "-37.690937, 145.078092", end_point: "-37.547523,143.850102", reward_point: sp10.danger, date: "12/02/2024", name: "Ballarat", car: car1)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "22/01/2024", name: "Sydney", car: car1)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car1)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "26/12/2023", name: "Drysdale", car: car1)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car3)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car1)
wp = Trip.create!(start_point: "-37.826034, 145.001111", end_point: "-38.916750,146.380524", reward_point: sp9.danger, date: "05/03/2024", name: "Wilson Promontory", car: car2)
sorrento = Trip.create!(start_point: "-37.798496, 144.979754", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "07/03/2024", name: "Sorrento", car: car2)
pi = Trip.create!(start_point: "-37.798665, 144.987446", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "28/02/2024", name: "Philip island", car: car2)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/03/2024", name: "Torquay", car: car2)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car1)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car1)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/03/2024", name: "Drysdale", car: car1)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car1)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car4)
wp = Trip.create!(start_point: "-37.826034, 145.001111", end_point: "-38.916750,146.380524", reward_point: sp9.danger, date: "05/03/2024", name: "Wilson Promontory", car: car4)
sorrento = Trip.create!(start_point: "-37.798496, 144.979754", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "07/03/2024", name: "Sorrento", car: car4)
pi = Trip.create!(start_point: "-37.798665, 144.987446", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "28/02/2024", name: "Philip island", car: car1)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/03/2024", name: "Torquay", car: car1)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car1)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car2)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/03/2024", name: "Drysdale", car: car1)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car1)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car4)
wp = Trip.create!(start_point: "-37.826034, 145.001111", end_point: "-38.916750,146.380524", reward_point: sp9.danger, date: "05/03/2024", name: "Wilson Promontory", car: car4)
sorrento = Trip.create!(start_point: "-37.798496, 144.979754", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "07/03/2024", name: "Sorrento", car: car4)
pi = Trip.create!(start_point: "-37.798665, 144.987446", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "28/02/2024", name: "Philip island", car: car1)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/03/2024", name: "Torquay", car: car1)
sorrento = Trip.create!(start_point: "-37.798496, 144.979754", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "07/03/2024", name: "Sorrento", car: car2)
pi = Trip.create!(start_point: "-37.798665, 144.987446", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "28/02/2024", name: "Philip island", car: car2)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/03/2024", name: "Torquay", car: car2)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car1)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car1)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/03/2024", name: "Drysdale", car: car1)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car1)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car4)
sorrento = Trip.create!(start_point: "-37.798496, 144.979754", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "07/03/2024", name: "Sorrento", car: car4)
pi = Trip.create!(start_point: "-37.798665, 144.987446", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "28/02/2024", name: "Philip island", car: car1)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/03/2024", name: "Torquay", car: car1)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car1)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car2)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/03/2024", name: "Drysdale", car: car1)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car1)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car4)
wp = Trip.create!(start_point: "-37.826034, 145.001111", end_point: "-38.916750,146.380524", reward_point: sp9.danger, date: "05/03/2024", name: "Wilson Promontory", car: car1)
sorrento = Trip.create!(start_point: "-37.798496, 144.979754", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "07/03/2024", name: "Sorrento", car: car1)
pi = Trip.create!(start_point: "-37.798665, 144.987446", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "28/02/2024", name: "Philip island", car: car4)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/03/2024", name: "Torquay", car: car2)
sorrento = Trip.create!(start_point: "-37.798496, 144.979754", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "07/03/2024", name: "Sorrento", car: car2)
pi = Trip.create!(start_point: "-37.798665, 144.987446", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "28/02/2024", name: "Philip island", car: car2)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/03/2024", name: "Torquay", car: car2)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car2)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car2)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/03/2024", name: "Drysdale", car: car2)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car2)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car2)
torq = Trip.create!(start_point: "-37.709392, 145.078092", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/03/2024", name: "Torquay", car: car2)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car2)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car2)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/03/2024", name: "Drysdale", car: car2)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car2)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car2)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car4)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car4)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/03/2024", name: "Drysdale", car: car4)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car4)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car4)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car4)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car4)
drysdale = Trip.create!(start_point: "-37.868674, 144.765000", end_point: "-38.159533,144.581264", reward_point: sp11.danger, date: "01/03/2024", name: "Drysdale", car: car6)
wollongong = Trip.create!(start_point: "-34.808265, 149.596138", end_point: "-34.673787, 150.488712", reward_point: sp3.danger, date: "01/03/2024", name: "Drysdale", car: car6)
callala = Trip.create!(start_point: "-34.064571, 151.018094", end_point: "-35.029419, 150.627125", reward_point: sp1.danger, date: "15/03/2024", name: "Drysdale", car: car6)
gor = Trip.create!(start_point: "-37.594619, 150.842759", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/03/2024", name: "Great Ocean Road", car: car2)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car6)
gor = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/09/2023", name: "Great Ocean Road", car: car5)
wp = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.916750,146.380524", reward_point: sp9.danger, date: "05/09/2023", name: "Wilson Promontory", car: car3)
sorrento = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "02/10/2023", name: "Sorrento", car: car5)
pi = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "09/11/2023", name: "Philip Island", car: car3)
torq = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/11/2023", name: "Torquay", car: car3)
sydney = Trip.create!(start_point: "-37.797219, 144.987657", end_point: "-33.958899,151.036390", reward_point: sp1.danger, date: "21/03/2024", name: "Sydney", car: car7)
gor = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.780864,143.430955", reward_point: sp8.danger, date: "12/09/2023", name: "Great Ocean Road", car: car7)
wp = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.916750,146.380524", reward_point: sp9.danger, date: "05/09/2023", name: "Wilson Promontory", car: car7)
sorrento = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "02/10/2023", name: "Sorrento", car: car7)
pi = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "09/11/2023", name: "Philip Island", car: car7)
torq = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/11/2023", name: "Torquay", car: car7)
wp = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.916750,146.380524", reward_point: sp9.danger, date: "05/09/2023", name: "Wilson Promontory", car: car7)
sorrento = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.337904,144.743811", reward_point: sp9.danger, date: "02/10/2023", name: "Sorrento", car: car7)
pi = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "09/11/2023", name: "Philip Island", car: car7)
torq = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.317497,144.321543", reward_point: sp8.danger, date: "10/11/2023", name: "Torquay", car: car7)
pi = Trip.create!(start_point: "-37.798176, 144.990387", end_point: "-38.490159,145.201303", reward_point: sp9.danger, date: "09/11/2023", name: "Philip Island", car: car7)


# Actual rewards
ActualReward.create!(trip: gor, strategic_point: sp8)
ActualReward.create!(trip: wp, strategic_point: sp9)
ActualReward.create!(trip: sorrento, strategic_point: sp9)
ActualReward.create!(trip: pi, strategic_point: sp9)
ActualReward.create!(trip: torq, strategic_point: sp8)
ActualReward.create!(trip: og, strategic_point: sp11)
ActualReward.create!(trip: bend, strategic_point: sp1)
ActualReward.create!(trip: epping, strategic_point: sp13)
ActualReward.create!(trip: ballarat, strategic_point: sp1)
ActualReward.create!(trip: sydney, strategic_point: sp2)
ActualReward.create!(trip: drysdale, strategic_point: sp13)
ActualReward.create!(trip: wollongong, strategic_point: sp3)

# journey_pic = URI.open("app/assets/images/journey_1.jpg")
# Trip.first.photo.attach(io: journey_pic, filename: "journey_1.jpg", content_type: "image/jpg")
# Trip.first.save!


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
