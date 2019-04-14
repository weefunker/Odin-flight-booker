class Flight < ApplicationRecord
 

  belongs_to :start_airport, class_name: "Airport", foreign_key: "start_airport_id"
  belongs_to :end_airport, class_name: "Airport", foreign_key: "end_airport_id"


  scope :start_search_results, -> (start_airport) {where start_airport: start_airport}
  scope :end_search_results, -> (end_airport) {where end_airport: end_airport}
  scope :date_search_results, -> (date) {where date: date}
  
  

# scope :start_airport_id, lambda { |start_airport_id|
#   where( "start_airport_id = ?", start_airport_id ) if start_airport_id != ""
# }

# scope :end_airport_id, lambda { |end_airport_id|
#   where( "end_airport_id = ?", end_airport_id ) if end_airport_id != ""
# }

# scope :date, lambda { |date|
#   where( "date = ?", date ) if date != ""
# }

end
