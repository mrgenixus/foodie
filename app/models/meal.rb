class Meal < ActiveRecord::Base
  validates :chef, presence: true
  validates :name, presence: true

  validates :day, presence: true

  validate :valid_day

  def valid_day
    errors.add(:day, "Date must not be in the past") if day < Time.now.to_date
  end

end