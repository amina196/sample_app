class MicropostsController < ApplicationController
before_filter :signed_in_user #only: [:create, :destroy] : useless because these are the only actions that we have !! :)
before_filter :correct_user, only: [:destroy]

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Your post has been successfully posted !"
			redirect_to root_path
		else
			@feed_items = []
			render 'pages/home'
		end
	end

	def destroy
		@micropost.destroy #@micropost defined in the correct_user private method, cf plus bas
		flash[:success] = "Post succesfully deleted"
		redirect_to root_path
	end
	
	private
	def correct_user
		@micropost = current_user.microposts.find_by_id(params[:id]) #we search the micropost sent in the delete request in the collection of microposts that belongs to the current user
																	#find_by_id returns nil/find raises an exception => we use find_by_id
		redirect_to root_path if @micropost.nil? 
	end

	
end