require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  context 'with a new family' do
    setup {@family = Family.new}
    
    should 'not be valid' do
      assert_not_valid @family
      assert_not_nil @family.errors.on(:password)
      assert_not_nil @family.errors.on(:name)
    end
    
    context 'with a too-short password' do
      setup do
        @family.attributes = {
          :password => 'p',
          :password_confirmation => 'p'
        }
      end
      
      should 'complain about the password' do
        assert_not_valid @family
        assert_not_nil @family.errors.on(:password)
      end
    end
    
    context 'with a valid unsaved record' do
      setup do
        @family.attributes = {
          :password => "PASS",
          :password_confirmation => "PASS",
          :name => "Smith"
        }
      end
      
      should 'be valid' do
        assert_valid @family
      end
      
      should_have_phone_like_field :external_contact_phone

      context 'after save' do
        setup { @family.save! }
        
        should 'create three meeting places' do
          assert_count 3, @family.meeting_places
        end

        should 'hardcode the names' do
          expected_names = [
            'Neighborhood Meeting Place',
            'Regional Meeting Place',
            'Evacuation Location'
          ]
          
          assert_equal expected_names, @family.meeting_places.map(&:name)
        end
        
        
        context 'with people' do
          setup {@family.people.create! :name => 'joe', :phone => '050 505 0055'}
          
          context 'after destroy' do
            setup {@family.destroy}
            should 'destroy the meeting places as well' do
              assert_empty MeetingPlace.find_all_by_family_id(@family.id)
            end
            
            should 'destroy the person as well' do
              assert_empty Person.find_all_by_family_id(@family.id)
            end
          end
        end
        
        should 'populate crypted password' do
          assert_not_nil @family.crypted_password
        end
        
        should 'authenticate against the correct password' do
          assert @family.authenticated?('PASS')
        end
        
        should 'authenticate case insensitively' do
          assert @family.authenticated?('pass')
        end
        
        should 'not authenticate against the incorrect password' do
          assert ! @family.authenticated?("not my password")
        end
        
        should 'still be valid after reload' do
          assert_valid Family.find(@family.id)
        end
      end
    end
  end
end
