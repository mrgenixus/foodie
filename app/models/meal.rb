class Meal < ActiveRecord::Base
  validates :chef, presence: true
  validates :name, presence: true

  validates :day, presence: true
  validates :dishwasher, presence: true

  validate :valid_day

  belongs_to :chef_user, class_name: User, foreign_key: :chef, primary_key: :name
  belongs_to :dishwasher_user, class_name: User, foreign_key: :dishwasher, primary_key: :name

  MEALTIMES = %W(breakfast second_breakfast brunch elevensies lunch sunday_dinner sunday_desert afternoon_tea supper dinner bachelors_dinner)

  def valid_day
    errors.add(:day, "Date must not be in the past") if day < Time.now.to_date
  end

end