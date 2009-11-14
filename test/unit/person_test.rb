require 'test_helper'

class PersonTest < ActiveSupport::TestCase
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
          :phone => '(123) 456-7890',
          :family => Family.new
        }
      end
      
      should 'be valid' do
        assert_valid @person
      end
    end
  end
end
