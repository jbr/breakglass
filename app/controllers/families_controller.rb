class FamiliesController < ApplicationController
	before_filter :login_required
	load_resource :family, :except => :index
	
	def index
	  @family = current_family
	  render :action => "show"
  end
	
  def show
    respond_to do |format|
      format.html
      format.mobile
    end
  end

	def update
		respond_to do |format|
			if @family.update_attributes(params[:family])
				format.html { redirect_to(@family) }
				format.xml  { head :ok }
				format.json { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml  => @record.errors.to_xml,  :status => :unprocessable_entity }
				format.json { render :json => @record.errors.to_json, :status => :unprocessable_entity }
			end
		end
	end
end
