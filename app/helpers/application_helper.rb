module ApplicationHelper
  def default_value_text_field(f, field_name, default_value)
    f.text_field field_name, :size => 16, :value => default_value,
      :onFocus => "if(this.value==this.defaultValue) this.value='';",
      :onBlur => "if(this.value=='') this.value=this.defaultValue;"
  end
end
