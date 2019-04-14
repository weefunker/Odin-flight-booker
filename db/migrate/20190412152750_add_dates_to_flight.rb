class AddDatesToFlight < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :date, :datetime
  end
end
