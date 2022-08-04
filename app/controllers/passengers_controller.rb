class PassengersController < ApplicationController
  def destroy
    @passenger = Passenger.find(params[:id])
    ticket = @passenger.flight_passengers.first
    ticket.destroy
    redirect_to '/flights'
  end
end