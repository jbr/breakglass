require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  context 'authentication' do
    context 'with a person that exists' do
      setup {assert_not_nil @expected_person = Person.find_by_phone("1234567890")}
      should 'authenticate with the correct password' do
        families(:ferroni).update_attributes!(:password => 'pass', :password_confirmation => 'pass')
        found = Person.authenticate @expected_person.phone, 'pass'
        assert_equal @expected_person, found
      end
      
      should 'not authenticate with an existing person but the incorrect password' do
        assert_nil Person.authenticate(@expected_person.phone, 'not my pass')
      end
      
      should 'not authenticate with a nonexistent person' do
        assert_nil Person.find_by_phone("hello")
        assert_nil Person.authenticate("hello", "doesn't matter")
      end
    end
  end
  
  context 'with a new person' do
    setup {@person = Person.new}
    should 'not be valid' do
      assert_not_valid @person
      assert_not_nil @person.errors.on(:phone)
    end
    
    context 'with an invalid phone' do
      setup {@person.phone = '123456'}
      should 'not be valid' do
        assert_not_valid @person
        assert_not_nil @person.errors.on(:phone)
      end
    end
    
    context 'phone format stripping' do
      setup {@person.phone = "(123) 456 - 7890"}
      should 'strip all nonnumeric characters on assignment' do
        assert_phone '1234567890', @person
      end
    end
    
    context 'with valid attributes' do
      setup do
        @person.attributes = {
          :phone => '(000) 456-7890',
          :family => Family.new
        }
      end
      
      should 'be valid' do
        assert_valid @person
      end
      
      should_have_phone_like_field :sms
      # should_have_phone_like_field :phone
      
      context 'with a duplicate phone' do
        setup {@person.phone = people(:cameron).phone}
        should 'not be valid' do
          assert_not_valid @person
          assert_not_nil @person.errors.on(:phone)
        end
      end
    end
  end
end
