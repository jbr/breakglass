class PeopleController < ApplicationController
  before_filter :login_required
  
  def create
    @person = current_family.people.build params[:person]
    @success = @person.save
    respond_to do |format|
      format.html
      format.js
    end
  end
end