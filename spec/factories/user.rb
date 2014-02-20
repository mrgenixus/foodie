FactoryGirl.define do
  factory :user do
    name "Hank Hill"
    email "hank@stricklandpropane.com"
    password 'propane1'
    password_confirmation 'propane1'
  end
end
