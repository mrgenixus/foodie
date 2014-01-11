class Venue < ActiveRecord::Base
  has_many :meals
end