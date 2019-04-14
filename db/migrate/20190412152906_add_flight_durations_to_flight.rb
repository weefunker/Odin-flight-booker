class AddFlightDurationsToFlight < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :flight_duration, :integer
  end
end
