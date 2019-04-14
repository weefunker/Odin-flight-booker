# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Airport.destroy_all unless Rails.env.production?
Flight.destroy_all unless Rails.env.production?

random_date1 = Date.today+rand(200) 
random_date2 = Date.today+rand(200) 
random_date3 = Date.today+rand(200) 
random_date4 = Date.today+rand(200) 
random_flight_time1 = rand(1..18)
random_flight_time2 = rand(1..18)
random_flight_time3 = rand(1..18)
random_flight_time4 = rand(1..18)

airport_list = ["JFK","ATL","PEK","LAX","HND","LHR","HKA","AMS","BKK","IRE"]

airport_list.each do |name|
    Airport.create!(name: name)
end 

puts "#{Airport.count} total airports created"

flight_list = [
    [Airport.ids.sample,Airport.ids.sample,random_date1,random_flight_time1],
    [Airport.ids.sample,Airport.ids.sample,random_date2,random_flight_time2],
    [Airport.ids.sample,Airport.ids.sample,random_date3,random_flight_time3],
    [Airport.ids.sample,Airport.ids.sample,random_date4,random_flight_time4],   
]

flight_list.each do |start_airport, end_airport, date, flight_duration|
    Flight.create!(start_airport_id: start_airport, end_airport_id: end_airport, date: date, flight_duration: flight_duration)
end 