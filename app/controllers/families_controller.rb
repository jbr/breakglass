class FamiliesController < ApplicationController
	before_filter :login_required
	
	def index
	  @family = current_family
	  render :action => "show"
  end
	
  def show
    @family = Family.find params[:id]
    respond_to do |format|
      format.html
      format.mobile
    end
  end

end
