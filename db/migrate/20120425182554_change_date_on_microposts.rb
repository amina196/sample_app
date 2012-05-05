class ChangeDateOnMicroposts < ActiveRecord::Migration
  def up
  	change_column(:microposts, :date, :date)
  end

  def down
  	change_column(:microposts, :date, :string)
  end
end
