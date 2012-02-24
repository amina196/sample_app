class Addcolumnstousers < ActiveRecord::Migration
  def up
	add_column (:users, :sex, :string)
  end

  def down
  end
end
