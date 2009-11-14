class MeetingPlacesController < ApplicationController
  before_filter :login_required
  def update
    @mp = MeetingPlace.find(params[:id])
    @mp.update_attributes params[:meeting_place]
    respond_to do |format|
      format.js
    end
  end
end
