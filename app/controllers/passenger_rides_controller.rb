class PassengerRidesController < ApplicationController
  before_filter :signed_in_user

  def create
    @ride = Micropost.find(params[:passenger_ride][:ride_id])
    current_user.hop_in!(@ride)
    @ride.nb_passengers = @ride.nb_passengers - 1
    redirect_to current_user
  end

  def destroy
    @ride = PassengerRide.find(params[:id]).ride
    current_user.jump_off!(@ride)
    @ride.nb_passengers = @ride.nb_passengers + 1
    redirect_to current_user
  end
end