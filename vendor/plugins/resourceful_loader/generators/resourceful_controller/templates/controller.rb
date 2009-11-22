class <%=class_name%>Controller < ApplicationController
  load_resource :<%=file_name.singularize%>, :by => :id
  
  def index
    @<%=file_name%> = <%=class_name.singularize%>.all
  end
  
  def show
  end
  
  def new
    @<%=file_name.singularize%> = <%=class_name.singularize%>.new
  end
  
  def edit
  end
  
  def update
    @success = @<%=file_name.singularize%>.update_attributes params[:<%=file_name.singularize%>]
    respond_to do |format|
      format.html do
        @success ? redirect_to(<%=file_name.singularize%>_url(@<%=file_name.singularize%>)) : render(:action => :edit)
      end
      format.js
    end
  end
  
  def create
    @<%=file_name.singularize%> = <%=class_name.singularize%>.new params[:<%=file_name.singularize%>]
    @success = @<%=file_name.singularize%>.save
    respond_to do |format|
      format.html do
        @success ? redirect_to(<%=file_name.singularize%>_url(@<%=file_name.singularize%>)) : render(:action => :new)
      end
      format.js
    end
  end
  
  def destroy
    @<%=file_name.singularize%>.destroy
    respond_to do |format|
      format.html { redirect_to <%=file_name%>_url }
      format.js
    end
  end
end