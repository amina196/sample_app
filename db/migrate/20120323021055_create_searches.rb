class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :start_town
      t.string :drop_town

      t.timestamps
    end
  end
end
