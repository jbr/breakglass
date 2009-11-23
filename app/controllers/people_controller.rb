class PeopleController < ApplicationController
  before_filter :login_required
  
  def create
    @person = current_family.people.build params[:person]
    @success = @person.save
    respond_to do |format|
      format.html { redirect_to current_family_url }
      format.js
    end
  end
end