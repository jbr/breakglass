class MeetingPlacesController < ApplicationController
  before_filter :login_required
  load_resource :meeting_place, :by => :id, :if_nil => :access_denied
  before_filter :meeting_place_must_be_associated_with_the_right_family
  
  def update
    @success = @meeting_place.update_attributes params[:meeting_place]
    respond_to do |format|
      format.js
    end
  end
  
  def meeting_place_must_be_associated_with_the_right_family
    unless @meeting_place.family == current_family
      redirect_to family_url(current_family)
      return false
    end
  end
end
