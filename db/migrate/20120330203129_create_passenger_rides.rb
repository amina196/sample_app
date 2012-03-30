class CreatePassengerRides < ActiveRecord::Migration
  def change
    create_table :passenger_rides do |t|
      t.integer :ride_id
      t.integer :passenger_id

      t.timestamps
    end

    add_index :passenger_rides, :ride_id
    add_index :passenger_rides, :passenger_id
    add_index :passenger_rides, [:ride_id, :passenger_id], unique: true #a user can't be a passenger in a ride twice
  end
end
