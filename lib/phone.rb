class Phone
  module Methods
    def strip_nonnumeric(phone)
      (phone || '').gsub /[^0-9]/, ''
    end
  	
    def phone_like_field(field_name)
      define_method :"#{field_name}=" do |content|
        self[field_name.to_s] = self.class.strip_nonnumeric content
      end
      
      define_method :"formatted_#{field_name}" do
        raw = send field_name
        unless raw.blank?
          "(#{raw[0..2]}) #{raw[3..5]}-#{raw[6..9]}"
        else
          ""
        end
      end
      
      validates_format_of field_name, :with => /[0-9]{10}/, :unless => lambda{|r| r.send(field_name).blank? }
      validates_uniqueness_of field_name, :unless => lambda{|r| r.send(field_name).blank? }
    end
    
    def phone_like_fields(*field_names)
      field_names.each {|p| phone_like_field p}
    end
  end
end
