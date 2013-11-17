class MealsController < ApplicationController
  before_action :lookup_meals, only: [:index]

  def index
  end

  def lookup_meals
    @meals = Meal.where(day: (Time.now.to_date..(7.days.from_now.to_date)))
  end


end