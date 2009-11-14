class Phone
  module Methods
    def strip_nonnumeric(phone)
  	  phone.gsub /[^0-9]/, ''
    end
  	
    def phone_like_field(field_name)
      define_method :"#{field_name}=" do |content|
        self[field_name.to_s] = self.class.strip_nonnumeric content
      end
      
      validates_format_of field_name, :with => /[0-9]{10}/
      validates_uniqueness_of field_name
    end
    
    def phone_like_fields(*field_names)
      field_names.each {|p| phone_like_field p}
    end
  end
end