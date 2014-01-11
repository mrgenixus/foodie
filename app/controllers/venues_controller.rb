class VenuesController < ApplicationController

  def create
    @venue = Venue.new params_for_venue

    if @venue.save
      respond_to do |format|
        format.json { render json: {success: true, venue: @venue } }
      end and return
    else
      respond_to do |format|
        format.json { render json: {errors: @venue.errors.full_messages }, status: 422 }
      end and return
    end

  end

  private

  def params_for_venue
    params.require(:venue).permit(:name, :address)
  end

end