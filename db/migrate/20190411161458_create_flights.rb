class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.references :start_airport, foreign_key: true
      t.references :end_airport, foreign_key: true

      t.timestamps
    end
  end
end
