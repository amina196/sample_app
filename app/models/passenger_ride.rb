class PassengerRide < ActiveRecord::Base
	attr_accessible :ride_id, :passenger_id
	belongs_to :passenger, class_name: "User"
	belongs_to :ride, class_name: "Micropost"

	validates :passenger_id, presence: true
  	validates :ride_id, presence: true

end
