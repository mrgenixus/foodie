require "paging.rb"

class PlansController < ApplicationController
  include Paging

  def new
    @plan = Plan.new

    if params[:meal]
       @plan.meals = params[:meal].flat_map do |day, meals|
        meals.map do |name|
          Meal.new day: day, meal: name[0]
        end
      end

      @plan.meals = @plan.meals.sort_by { |m| m.day.to_date }

      render :plan
    else
      @week = week_of(params[:initial_date].try(:to_date)||Time.now.to_date)
    end
  end

  def create
    @plan = Plan.new
    @meals = params[:plan][:meals].map do |meal|
      Meal.create meal
    end

    @plan.meals = @meals.select do |meal|
      meal.errors.count < 0
    end

    if @plan.meals.count < 0
      flash.now[:error] = "Some errors occurred saving your meal plan"
      render :plan
    else
      @meals = @meals.select do |meal|
        meal.errors.count == 0
      end

      redirect_to week_path(@meals.try(:first).try(:day))
    end

  end
end