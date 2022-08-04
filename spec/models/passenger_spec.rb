require 'rails_helper'

RSpec.describe Passenger do
  describe 'relationships' do
    it { should have_many :flight_passengers }
    it { should have_many(:flights).through(:flight_passengers) }
  end

  describe '.class methods' do
    it 'shows a unique list of passengers' do
      air_1 = Airline.create!(name: "American")
      flight_1 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )


      pass_1 = flight_1.passengers.create!(name: "Brennan Lee Mulligan", age: 33)
      pass_2 = flight_1.passengers.create!(name: "Misty Moore", age: 44)
      pass_3 = flight_1.passengers.create!(name: "Bill Seacaster", age: 46)
      pass_4 = flight_1.passengers.create!(name: "Bill Seacaster", age: 46)

      expect(Passenger.unique).to eq([ pass_3, pass_1, pass_2])
    end
  end
end