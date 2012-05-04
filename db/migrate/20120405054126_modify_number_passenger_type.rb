class ModifyNumberPassengerType < ActiveRecord::Migration
  def up
  		 
    rename_column :microposts, :nb_passengers, :nb_passengers_string
    add_column :microposts, :nb_passengers, :integer

    Micropost.reset_column_information
    Micropost.find(:all).each { |post| post.update_attribute(:nb_passengers, contact.nb_passengers_string) }
    remove_column :contacts, :nb_passengers_string
  end

  end

end
