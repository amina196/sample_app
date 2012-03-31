class ChangeDataTypeForMicropostNbPassengers < ActiveRecord::Migration
  def change
  	change_table :microposts do |t|
      t.change :nb_passengers, :integer
    end
  end

  
end
