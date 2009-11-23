require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  context 'create' do
    context 'when logged in' do
      setup do
        @current_person = log_in_as :jacob
        post_create_for_family @current_person.family
      end
      
      should 'create a person on the current family' do
        @new_person = Person.last
        assert_name @new_person_params[:name], @new_person
        assert_family @current_person.family, @new_person
      end
    end
    
    context 'when not logged in' do
      setup { post_create_for_family :rothstein }
      
      should 'not create a person' do
        assert_not_name @new_person_params[:name], Person.last
      end
      
      should 'redirect to log in url' do
        assert_redirected_to new_session_url
      end
    end
  end
  
  def post_create_for_family(family)
    family = families family if family.is_a? Symbol
    @new_person_params = {:name => "Elizabeth", :phone => "800-121-0000"}
    post :create, :person => @new_person_params, :family_id => family.to_param
  end
end
