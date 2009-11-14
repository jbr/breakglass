class FamiliesController < ApplicationController
	before_filter :login_required
	
  def show
    @family = Family.find(params[:id])
    respond_to do |format|
      format.html
      format.mobile
    end
  end

end
