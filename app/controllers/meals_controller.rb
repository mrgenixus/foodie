class MealsController < ApplicationController
  before_action :lookup_meals, only: [:index]
  before_action :lookup_meal, only: [:edit, :update, :show]

  def index
  end

  def edit
  end

  def update
    lookup_meal.update_attributes params_for_meal

    redirect_to meal_path(lookup_meal)
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new params_for_meal

    if @meal.save
      flash[:notice] = "Meal saved"

      redirect_to meal_path(@meal)

    else
      flash[:error] = "Meal note Saved"

      redirect_to new_meal_path
    end
  end


  def show
  end

  def destroy
    if lookup_meal.delete
      flash[:notice] = "Meal Deleted"
    else
      flash[:error] = 'Unable to delete Meal'
    end

    redirect_to :meals
  end

  def params_for_meal
    params.require(:meal).permit(:name, :description, :chef, :day, :meal)
  end

  def lookup_meal
    @meal ||= Meal.find(params[:id])
  end

  def lookup_meals
    @meals = Meal.order(:day).where(day: (Time.now.to_date..(7.days.from_now.to_date)))
  end


end