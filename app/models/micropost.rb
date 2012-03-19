class Micropost < ActiveRecord::Base
	attr_accessible :content
	belongs_to :user
	validates :content, presence: true, length: {maximum: 140}
	default_scope order: 'microposts.created_at DESC' #order the microposts, most recent first
	
	def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end
end
