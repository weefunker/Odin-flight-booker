class AddNamesToPassenger < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :name, :string
  end
end
