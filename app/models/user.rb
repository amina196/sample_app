class User < ActiveRecord::Base

	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password

#associations
	has_many :microposts

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
		Micropost.where("user_id = ?",id) #id is properly escaped before being included in the underlying SQL query, at this point this is equivalent to "microposts"
	end
	
	
end
