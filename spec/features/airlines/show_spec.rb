require 'rails_helper'

RSpec.describe 'airlines show page' do
  it 'shows a unique list of passengers' do
    air_1 = Airline.create!(name: "American")

    flight_1 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )

    pass_1 = Passenger.create!(name: "Brennan Lee Mulligan", age: 33)
    pass_2 = Passenger.create!(name: "Misty Moore", age: 44)
    pass_3 = Passenger.create!(name: "Danny Moore", age: 15)
    pass_4 = Passenger.create!(name: "Bill Seacaster", age: 46)
    pass_5 = Passenger.create!(name: "Bill Seacaster", age: 69)

    fli_pas1 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_1.id)
    fli_pas2 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_2.id)
    fli_pas3 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_3.id)
    fli_pas4 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_4.id)
    fli_pas5 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_5.id)

    visit airline_path(air_1.id)

    expect(page).to have_content("Brennan Lee Mulligan - Age 33")
    expect(page).to have_content("Misty Moore - Age 44")
    expect(page).to have_content("Bill Seacaster - Age 46")
    expect(page).to_not have_content("Danny Moore - Age 15")
    expect(page).to_not have_content("Bill Seacaster - Age 69")
  end
end