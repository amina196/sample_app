class Relationship < ActiveRecord::Base	
	attr_accessible :followed_id
#associations	
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
	
#validations (use the names of the table attributes ! )
	#validates: :follower_id, presence: true
	#validates: :followed_id, presence: true
end
