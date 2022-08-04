require 'rails_helper'

RSpec.describe 'airlines show page' do
  it 'shows a unique list of passengers' do
    air_1 = Airline.create!(name: "American")

    flight_1 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )
    flight_2 = air_1.flights.create!(number: "3940", date: "3/10/2022", departure_city: "Detroit", arrival_city: "Orlando" )
    flight_3 = air_1.flights.create!(number: "2030", date: "10/07/2022", departure_city: "Portland", arrival_city: "Las Vegas" )

    pass_1 = Passenger.create!(name: "Brennan Lee Mulligan", age: 33)
    pass_2 = Passenger.create!(name: "Misty Moore", age: 44)
    pass_3 = Passenger.create!(name: "Danny Jones", age: 15)

    fli_pas1 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_1.id)
    fli_pas2 = FlightPassenger.create!(flight_id: flight_2.id, passenger_id: pass_1.id)
    fli_pas3 = FlightPassenger.create!(flight_id: flight_3.id, passenger_id: pass_1.id)

    fli_pas4 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_1.id)
    fli_pas5 = FlightPassenger.create!(flight_id: flight_2.id, passenger_id: pass_2.id)
    fli_pas6 = FlightPassenger.create!(flight_id: flight_3.id, passenger_id: pass_3.id)

    visit airline_path(air_1.id)

    expect(page).to have_content(pass_1.name, count: 1)
    expect(page).to have_content(pass_2.age, count: 1)
    expect(page).to_not have_content(pass_3.name)
  end
end