require "paging.rb"

class MealsController < ApplicationController

  before_filter :authenticate_user!, only: [:edit, :update, :new, :ceate]

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
      format.ics do
        calendar = Icalendar::Calendar.new
        @meals.each {|meal| calendar.add_event(meal.to_ics) }
        calendar.publish
        render :text => calendar.to_ical
      end
    end
  end

  def update
    lookup_meal.update_attributes params_for_meal

    redirect_to meal_path(lookup_meal)
  end

  def new
    @meal = Meal.new day: default_date
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
    respond_to do |format|
      format.html # => render :show
      format.json { render json: @meal }
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@meal.to_ics)
        calendar.publish
        render :text => calendar.to_ical
      end
    end
  end

  def next
    meals = Meal.order(:day)
    meals = meals.where("? IN (chef, dishwasher)", current_user.name) if params[:use_current_user]
    @meal = meals.first

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @meal }
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@meal.to_ics)
        calendar.publish 
        render :text => calendar.to_ical
      end
    end
  end

  def show
    respond_to do |format|
      format.html # => render :show
      format.json { render json: @meal }
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@meal.to_ics)
        calendar.publish
        render :text => calendar.to_ical
      end
    end
  end


  def week
    @date_range = week_of((params[:date]||Time.now).to_date)
    @meals = Meal.where(day: @date_range)
    new
    respond_to do |format|
      format.html
      format.json { render json: @meals }
      format.ics do
        calendar = Icalendar::Calendar.new
        @meals.each {|meal| calendar.add_event(meal.to_ics) }
        calendar.publish
        render :text => calendar.to_ical
      end
    end
  end

  private 

  def last_meal
    [ Time.now.to_date, (Meal.order(:day).last.try(:day) || 1.day.ago) + 1.day].max
  end

  def default_date
    params[:initial_date] ? params[:initial_date] : last_meal
  end

end