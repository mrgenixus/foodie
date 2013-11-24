require "paging.rb"

class MealsController < ApplicationController
  before_action :lookup_meals, only: [:index]
  before_action :lookup_meal, only: [:edit, :show]

  helper :date_pager

  include Paging
  def index
    new
    @meals = @meals.where("? IN (chef, dishwasher)", current_user.name) if params[:use_current_user]
    respond_to do |format|
      format.html
      format.json { render json: @meals }
    end
  end

  def update
    lookup_meal.update_attributes params_for_meal

    redirect_to meal_path(lookup_meal)
  end

  def new
    @meal = Meal.new day: last_meal
  end

  def create
    @meal = Meal.new params_for_meal

    if @meal.save
      flash[:notice] = "Meal saved"

      redirect_to meal_path(@meal)

    else
      flash[:error] = "Unable to save Meal"

      render "new"
    end
  end

  def destroy
    if lookup_meal.delete
      render json: { success: true}
    end
  end

  def params_for_meal
    params.require(:meal).permit(:name, :description, :chef, :day, :meal, :dishwasher)
  end

  def lookup_meal
    @meal ||= Meal.find(params[:id])
  end

  def lookup_meals
    @meals = Meal.order(:day).where(day: paged_week)
  end

  def today
    @meals = Meal.where(day: Time.now.to_date)
    new
  end

  def next
    meals = Meal.order(:day)
    meals = meals.where("? IN (chef, dishwasher)", current_user.name) if params[:use_current_user]
    @meal = meals.first

    render :show
  end


  def week
    @date_range = week_of((params[:date]||Time.now).to_date)
    @meals = Meal.where(day: @date_range)
    new
  end

  private 

  def last_meal
    params[:initial_date] ? params[:initial_date] : [ Time.now.to_date, Meal.order(:day).last.day + 1.day].max
  end

end