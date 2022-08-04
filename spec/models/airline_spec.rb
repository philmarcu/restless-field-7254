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
        air_2 = Airline.create!(name: "United")
        
        flight_1 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )
        flight_2 = air_2.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )
  
  
        pass_1 = flight_1.passengers.create!(name: "Brennan Lee Mulligan", age: 33)
        pass_2 = flight_1.passengers.create!(name: "Misty Moore", age: 44)
        pass_3 = flight_1.passengers.create!(name: "Bill Seacaster", age: 46)
        pass_4 = flight_1.passengers.create!(name: "Danny Moore", age: 15)
        pass_5 = flight_2.passengers.create!(name: "Brennan Lee Mulligan", age: 33)
  
        expect(air_1.adult_passengers).to eq([pass_1, pass_2, pass_3])
        expect(air_2.adult_passengers).to eq([pass_5])
      end
    end
  end
end