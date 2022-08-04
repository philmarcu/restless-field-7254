require 'rails_helper'

RSpec.describe 'flight index page' do
  describe 'I see a list of all flights and their info' do
    it 'shows me all flights #s & Airline name' do
      air_1 = Airline.create!(name: "American")
      air_2 = Airline.create!(name: "United")

      flight_1 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )
      flight_2 = air_1.flights.create!(number: "3940", date: "3/10/2022", departure_city: "Detroit", arrival_city: "Orlando" )
      flight_3 = air_2.flights.create!(number: "9091", date: "5/17/2022", departure_city: "Chicago", arrival_city: "Kansas City" )

      visit flights_path

      within "#flight-#{flight_1.id}" do
        expect(page).to have_content("Flight #: 7990")
        expect(page).to have_content("Airline: American")
        expect(page).to_not have_content("Flight #: 3940")
        expect(page).to_not have_content("Flight #: 9091")
        expect(page).to_not have_content("Airline: United")
      end

      within "#flight-#{flight_2.id}" do
        expect(page).to have_content("Flight #: 3940")
        expect(page).to have_content("Airline: American")
        expect(page).to_not have_content("Flight #: 9091")
        expect(page).to_not have_content("Flight #: 7990")
        expect(page).to_not have_content("Airline: United")
      end

      within "#flight-#{flight_3.id}" do
        expect(page).to have_content("Flight #: 9091")
        expect(page).to have_content("Airline: United")
        expect(page).to_not have_content("Flight #: 3940")
        expect(page).to_not have_content("Flight #: 3940")
        expect(page).to_not have_content("Airline: American")
      end
    end

    it 'shows all the passengers within a flight' do
      air_1 = Airline.create!(name: "American")
      air_2 = Airline.create!(name: "United")

      flight_1 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )
      flight_2 = air_1.flights.create!(number: "3940", date: "3/10/2022", departure_city: "Detroit", arrival_city: "Orlando" )
      flight_3 = air_2.flights.create!(number: "9091", date: "5/17/2022", departure_city: "Chicago", arrival_city: "Kansas City" )

      pass_1 = flight_1.passengers.create!(name: "Brennan Lee Mulligan", age: 33)
      pass_2 = flight_1.passengers.create!(name: "Misty Moore", age: 44)
      pass_3 = flight_1.passengers.create!(name: "Bill Seacaster", age: 46)

      pass_4 = flight_2.passengers.create!(name: "Kingston Brown", age: 84)
      pass_5 = flight_2.passengers.create!(name: "Aabria Iyengar", age: 9)

      pass_6 = flight_3.passengers.create!(name: "Jimmy Westbrick", age: 12)
      pass_7 = flight_3.passengers.create!(name: "Old Greg", age: 34)

      visit flights_path

      within "#flight-#{flight_1.id}" do
        expect(page).to have_content("Brennan Lee Mulligan")
        expect(page).to have_content("Misty Moore")
        expect(page).to have_content("Bill Seacaster")
        expect(page).to_not have_content("Kingston Brown")
        expect(page).to_not have_content("Old Greg")
      end

      within "#flight-#{flight_2.id}" do
        expect(page).to have_content("Kingston Brown")
        expect(page).to have_content("Aabria Iyengar")
        expect(page).to_not have_content("Brennan Lee Mulligan")
        expect(page).to_not have_content("Jimmy Westbrick")
      end

      within "#flight-#{flight_3.id}" do
        expect(page).to have_content("Jimmy Westbrick")
        expect(page).to have_content("Old Greg")
        expect(page).to_not have_content("Brennan Lee Mulligan")
        expect(page).to_not have_content("Kingston Brown")
      end
    end
  end
end