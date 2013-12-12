class SessionsController < ApplicationController
  def update
    session.merge!(sessions_params)

    respond_to do |format|
      format.json { render json: { success: true }}
    end
  end

  private

  def sessions_params
    params.require(:session).permit(:time_zone)
  end
end