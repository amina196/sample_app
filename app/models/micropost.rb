class Micropost < ActiveRecord::Base
	attr_accessible :content, :start_location, :start_town, :drop_town, :drop_location, :date, :nb_passengers, :id
	belongs_to :user

	#needed to have user.rides array
	has_many :passenger_rides, foreign_key: "ride_id", dependent: :destroy
	
	has_many :passengers, through: :passenger_rides

	#validates :content, presence: true, length: {maximum: 140}
	default_scope order: 'microposts.created_at DESC' #order the microposts, most recent first
	
	def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end
  
  def self.search(search)
	if search
		find(:all, :conditions => ['start_town LIKE ?', "%#{search}%"])
	else
		find(:all)
	end
  end
end
