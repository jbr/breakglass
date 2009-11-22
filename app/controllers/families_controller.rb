class FamiliesController < ApplicationController
	before_filter :login_required
	load_resource :family, :except => :index, :if_nil => :access_denied, :by => :id
	before_filter :family_must_be_current_family, :except => :index
	
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
	  @success = @family.update_attributes params[:family]
	  
		respond_to do |format|
			if @success
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
	
	private
	def family_must_be_current_family
  	unless @family == current_family
      redirect_to family_url(current_family)
      return false
    end
  end
end
