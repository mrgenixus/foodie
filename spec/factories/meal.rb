FactoryGirl.define do
  factory :meal, class: Meal do
    name "Test Meal"
    day 1.day.from_now
    meal "Breakfast" # do we need to create this, too?
    chef "Hank Hill"
    dishwasher "Hank Hill"
  end
end