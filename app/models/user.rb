class User < ActiveRecord::Base

	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password

#associations
	has_many :microposts, dependent: :destroy
	
	#needed to have user.followed_users	array
	has_many :relationships, foreign_key: "follower_id", #what identifies a user in the relationship table is the follower_id attribute
							 dependent: :destroy # if a user is destroyed we want his relationships to be destroyed too 
																		
	has_many :followed_users, through: :relationships, 
							  source: :followed  #becessary because the plural of :followed_users != :followeds 
							  
	#needed to have the user.followers array
	has_many :reverse_relationships, foreign_key: "followed_id", 
									 class_name: "Relationship", #have to include the class name for this association otherwise Rails would be looking at a ReverseRelationship class which doesn't exist
									 dependent: :destroy
									 
	has_many :followers, through: :reverse_relationships, 
						 source: :follower #unnecessary, since Rails will singularize “followers” and automatically look for the foreign key follower_id in this case

#callbacks 
	before_save :create_remember_token
	
#validations
  validates :name, presence: true, length: { maximum: 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6}

  
#helpers  
	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64 #generate a random string
	end
	
	def feed
		Micropost.from_users_followed_by(self) #id is properly escaped before being included in the underlying SQL query, at this point this is equivalent to "microposts"
	end
	
	#follow! method calls create! through the relationships association to create the following relationship
	def follow! (other)
		self.relationships.create!(followed_id: other.id)
	end
	
	def unfollow! (other)
		self.relationships.find_by_followed_id(other.id).destroy
	end
	
	#following? method takes in a user, called other, and checks to see if a followed user with that id exists in the database
	def following?(other)
		self.relationships.find_by_followed_id(other.id) #followed_id = name of the attribute as it appears in relationships
	end
	
	
end
