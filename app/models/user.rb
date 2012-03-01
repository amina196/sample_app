class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  #we added a new attribute for each user = remember_token for sessions
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6}

  
  
  
	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64 #generate a random string
	end
end
