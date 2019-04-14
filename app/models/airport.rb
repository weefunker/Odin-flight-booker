class Airport < ApplicationRecord
    has_many :flights 
    has_many :start_airports, class_name: "Flight", foreign_key: "start_airport_id"
    has_many :end_airports, class_name: "Flight", foreign_key: "end_airport_id"
    has_many :departing_flights, through: :start_airports
    has_many :arriving_flights, through: :end_airports
end
