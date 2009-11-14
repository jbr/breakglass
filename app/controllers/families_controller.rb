class FamiliesController < ApplicationController
	
  def show
    @family = Family.find(params[:id])
    respond_to do |format|
      format.html
      format.mobile
    end
  end

end
