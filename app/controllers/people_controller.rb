class PeopleController < ApplicationController
  before_filter :login_required
  
  def create
    @person = current_family.people.build params[:person]
    @success = @person.save
    respond_to do |format|
      format.js
      format.html { redirect_to current_family_url }
    end
  end
end