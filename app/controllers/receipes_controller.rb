class ReceipesController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: [{name: "dummy", id: 0}]}
      format.html
    end
      
  end
end