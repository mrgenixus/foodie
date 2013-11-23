class Meal < ActiveRecord::Base
  validates :chef, presence: true
  validates :name, presence: true

  validates :day, presence: true
  validates :dishwasher, presence: true

  validate :valid_day

  MEALTIMES = %W(breakfast second_breakfast brunch elevensies lunch sunday_dinner sunday_desert afternoon_tea supper dinner bachelors_dinner)

  def valid_day
    errors.add(:day, "Date must not be in the past") if day < Time.now.to_date
  end

end