class Passenger < ApplicationRecord
  has_many :flight_passengers
  has_many :flights, through: :flight_passengers

  def self.unique
    select("DISTINCT ON(passengers.name) passengers.*")
  end
end