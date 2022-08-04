class FlightPassengersController < ApplicationController
  def destroy
    flight = Flight.find(params[:flight_id])
    passenger = flight.flight_passengers.find_by(passenger_id: params[:passenger_id])
    passenger.destroy
    redirect_to '/flights'
  end
end