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
