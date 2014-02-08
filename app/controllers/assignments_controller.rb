class AssignmentsController < ApplicationController
  def create
    @meal = Meal.find(params[:meal_id])

    @meal.chef = current_user.name if params[:role] == 'chef'
    @meal.dishwasher = current_user.name if params[:role] == 'dishwasher'
  
    if @meal.save!
      flash[:notice] = "Assignment Saved"
    else
      flash[:error] = "Unable to Save Assigment"
    end
  end
end