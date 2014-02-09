class ReceipesController < ApplicationController

  before_filter :get_receipe, only: [:show, :edit, :update]

  def index
    @receipes = Receipe.order(:name)

    respond_to do |format|
      format.json { render json: @receipes }
      format.html
    end
      
  end

  def create
    @receipe = Receipe.new(params_for_receipe)

    if @receipe.save
      respond_to do |format|
        format.json { render json: { success: true, reciepe: @receipe } }
        format.html do
          flash[:notice] = "Receipe added successully"
          redirect_to @receipe
        end
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @receipe.errors }, status: 422 }
        format.html do
          flash[:error] = @receipe.errors.full_messages
          redirect_to :new
        end
      end
    end
  end

  def update
    if @receipe.update_attributes params_for_receipe
      respond_to do |format|
        format.json { render json: { success: true, reciepe: @receipe } }
        format.html do
          flash[:notice] = "Receipe Updated successully"
          redirect_to @receipe
        end
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @receipe.errors }, status: 422 }
        format.html do
          flash[:error] = @receipe.errors.full_messages
          redirect_to :edit
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @receipe }
      format.html
    end
  end

  private

  def params_for_receipe
    params.require(:receipe).permit(:name)
  end

  def get_receipe
    @receipe = Receipe.find(params[:id])
  end
end