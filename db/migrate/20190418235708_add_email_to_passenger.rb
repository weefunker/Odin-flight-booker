class AddEmailToPassenger < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :email, :string
  end
end
