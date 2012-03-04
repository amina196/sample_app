class Micropost < ActiveRecord::Base
	attr_accessible :content
	belongs_to :user
	validates :content, presence: true, length: {maximum: 140}
	default_scope order: 'microposts.created_at DESC' #order the microposts, most recent first
end
