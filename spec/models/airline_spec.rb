require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it { should have_many :flights }
    it { should have_many(:flight_passengers).through(:flights) }
    it { should have_many(:passengers).through(:flight_passengers)}
  end

  describe '#instance_methods' do
    describe '#adult_passengers' do
      it 'gets all the unique adult passengers for a flight' do
        air_1 = Airline.create!(name: "American")
        
        flight_1 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )
        flight_2 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Orlando", arrival_city: "Houston" )
  
  
        pass_1 = Passenger.create!(name: "Brennan Lee Mulligan", age: 33)
        pass_2 = Passenger.create!(name: "Misty Moore", age: 44)
        pass_3 = Passenger.create!(name: "Bill Seacaster", age: 46)
        pass_4 = Passenger.create!(name: "Danny Moore", age: 15)

        fli_pas1 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_1.id)
        fli_pas2 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_2.id)
        fli_pas3 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_3.id)
        fli_pas4 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_4.id)

        fli_pas2 = FlightPassenger.create!(flight_id: flight_2.id, passenger_id: pass_1.id)
      
        expect(air_1.adult_passengers).to eq([pass_1, pass_2, pass_3])
      end
    end
  end
end