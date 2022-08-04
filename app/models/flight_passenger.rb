class FlightPassenger < ApplicationRecord
  belongs_to :flight
  belongs_to :passenger
  has_many :airlines, through: :flight
end