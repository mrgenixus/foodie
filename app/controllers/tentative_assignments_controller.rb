class TentativeAssignmentsController < ApplicationController
  def create
    @tentative_assignment = TentativeAssignment.new(params_for_tentative_assignment)
  end

  private

  def params_for_tentative_assignment
    params.require('meal').permit(:meal_id, :role, :user_name)
  end
end