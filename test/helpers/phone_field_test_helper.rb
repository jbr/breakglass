module PhoneLikeFieldTestHelper
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  def class_name
    class_name = self.class.name.gsub("Test", '')
  end
  
  def object
    instance_variable_get("@#{class_name.underscore}") ||
      class_name.constantize.new
  end
  
  module ClassMethods
    def should_have_phone_like_field(field_name)
      context "phone-like-field #{field_name}" do
        context 'writer' do
          should 'strip nonnumeric characters' do
            object.send :"#{field_name}=", "h3ll0"
            assert_equal "30", object.send(field_name)
          end
        end
          
        context "with a valid #{field_name}" do
          setup {object.send :"#{field_name}=", '0001112222'}
          should "look like a phone number if the #{field_name} is set" do
            assert_equal '(000) 111-2222', object.send(:"formatted_#{field_name}")
          end
              
          should 'be valid' do
            assert_valid object
          end
        end
          
        context "with an invalid #{field_name}" do
          setup {object.send "#{field_name}=", "111"}
              
          should 'not be valid' do
            assert_not_valid object
          end
        end
          
        context "with another record that has the same #{field_name}" do
          setup do
            other_record = class_name.constantize.first(:conditions => "#{field_name} IS NOT NULL")
            object.send "#{field_name}=", other_record.send(field_name)
          end
              
          should 'not be valid' do
            assert_not_valid object
          end
        end
        
        context "with another record that has a blank #{field_name}" do
          setup do
            @other_record = class_name.constantize.first(:conditions => "#{field_name} IS NOT NULL")
            assert_valid @other_record
            @blank_field_valid = @other_record.update_attributes field_name => ''
            object.send "#{field_name}=", @other_record.send(field_name)
          end
              
          should "have errors on #{field_name} if the other record was valid" do
            assert_equal @blank_field_valid, object.valid?
          end
        end
        
        context "when the #{field_name} is blank" do
          setup { object.send "#{field_name}=", nil }
          should "have a blank formatted accessor" do
            assert_equal '', object.send("formatted_#{field_name}")
          end
        end
      end
    end
  end
end

ActiveSupport::TestCase.send :include, PhoneLikeFieldTestHelper