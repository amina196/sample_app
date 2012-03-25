class AddColumnsToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :start_town, :string

    add_column :microposts, :start_location, :string

    add_column :microposts, :drop_town, :string

    add_column :microposts, :drop_location, :string

    add_column :microposts, :date, :string

    add_column :microposts, :nb_passengers, :string

  end
end
