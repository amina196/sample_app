class PassengerRidesController < ApplicationController
  before_filter :signed_in_user

  def create
    @ride = Micropost.find(params[:passenger_ride][:ride_id])
    current_user.hop_in!(@ride)
    @ride.decrement!(:nb_passengers)
    redirect_to request.referer
  end

  def destroy
    @ride = PassengerRide.find(params[:id]).ride
    current_user.jump_off!(@ride)
    @ride.increment!(:nb_passengers)
    redirect_to request.referer
  end
end