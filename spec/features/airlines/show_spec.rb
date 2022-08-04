require 'rails_helper'

RSpec.describe 'airlines show page' do
  it 'shows a unique list of passengers' do
    air_1 = Airline.create!(name: "American")
    air_2 = Airline.create!(name: "United")

    flight_1 = air_1.flights.create!(number: "7990", date: "2/7/2022", departure_city: "Glendale", arrival_city: "Dallas" )
    flight_2 = air_1.flights.create!(number: "3940", date: "3/10/2022", departure_city: "Detroit", arrival_city: "Orlando" )
    flight_3 = air_2.flights.create!(number: "2030", date: "10/07/2022", departure_city: "Portland", arrival_city: "Las Vegas" )

    pass_1 = Passenger.create!(name: "Brennan Lee Mulligan", age: 33)
    pass_2 = Passenger.create!(name: "Misty Moore", age: 44)
    pass_3 = Passenger.create!(name: "Danny Jones", age: 15)
    pass_4 = Passenger.create!(name: "Jac Dedarco", age: 35)
    pass_5 = Passenger.create!(name: "Lafonza Wayans", age: 27)

    fli_pas1 = FlightPassenger.create!(flight_id: flight_1.id, passenger_id: pass_1.id)
    fli_pas2 = FlightPassenger.create!(flight_id: flight_2.id, passenger_id: pass_1.id)
    fli_pas3 = FlightPassenger.create!(flight_id: flight_3.id, passenger_id: pass_1.id)

    fli_pas4 = FlightPassenger.create!(flight_id: flight_3.id, passenger_id: pass_3.id)
    fli_pas4 = FlightPassenger.create!(flight_id: flight_3.id, passenger_id: pass_5.id)

    fli_pas5 = FlightPassenger.create!(flight_id: flight_2.id, passenger_id: pass_2.id)
    fli_pas6 = FlightPassenger.create!(flight_id: flight_2.id, passenger_id: pass_4.id)


    visit airline_path(air_1.id)

    expect(page).to have_content("Brennan Lee Mulligan - Age 33", count: 1)
    expect(page).to have_content("Misty Moore - Age 44", count: 1)
    expect(page).to have_content("Jac Dedarco - Age 35", count: 1)
    expect(page).to_not have_content("Danny Jones - Age 15")
    expect(page).to_not have_content("Lanfonza Wayans - Age 27")

    visit airline_path(air_2.id)

    expect(page).to have_content("Brennan Lee Mulligan", count: 1)
    expect(page).to have_content("Lafonza Wayans - Age 27", count: 1)
    expect(page).to_not have_content("Danny Jones - Age 15")
    expect(page).to_not have_content("Jac Dedarco - Age 35")
    expect(page).to_not have_content(pass_4.name)
  end
end