class AddRememberTokenToUsers < ActiveRecord::Migration
  #code to have to protect myself if I decide to erase the create_remember_token in the user.rb code
  #class User < ActiveRecord::Base
    #def create_remember_token
	  
	#end
  #end
	
  def change
	add_column :users, :remember_token, :string
	add_index :users, :remember_token
	
	#User.all.each do |user|
		#user.create_remember_token
		#user.save
	#end
	
  end
end
