require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class <%=class_name%>ControllerTest < ActionController::TestCase
  context 'with an existing <%=file_name.singularize%>' do
    setup {@<%=file_name.singularize%> = <%=class_name.singularize%>.first}
    context "on GET to :show" do
      setup { get :show, :id => @<%=file_name.singularize%>.to_param }
      should_assign_to :<%=file_name.singularize%>
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end

    context "on POST to :update" do
      setup { post :update, :id => @<%=file_name.singularize%>.to_param, :<%=file_name.singularize%> => {} }
      should_assign_to :<%=file_name.singularize%>
      should_redirect_to("the <%=file_name.singularize%>") { <%=file_name.singularize%>_url @<%=file_name.singularize%>}
    end
  end
end
