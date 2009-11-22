module ResourcefulLoader
  mattr_accessor :default_finder
  def self.included(klass)
    klass.module_eval do
      extend ClassMethods
    end
  end

  def element_id
    [self.class.name.underscore, to_param.blank?? "new" : to_param].join '_'
  end

  module ClassMethods
    def load_resource(resource_name, options = {})
      options.stringify_keys!
      resource_name = resource_name.to_s.underscore.singularize
      method_name = :"load_#{resource_name}"
      param_name = options.delete('by') || resource_name.foreign_key
      finder_method = (options.delete('method') || ResourcefulLoader.default_finder || "find_by_id").to_sym
      
      if_nil = options.delete("if_nil")

      self.class_eval do
        define_method(method_name) do
          return unless foreign_key = params[param_name]
          resource = block_given? ? yield(foreign_key) : resource_name.classify.constantize.send(finder_method, foreign_key)
          if resource.nil? && if_nil && !if_nil.to_proc.call(self)
            return false
          end
          self.instance_variable_set :"@#{resource_name}", resource
        end
        private method_name

        before_filter method_name, options
      end
    end
  end
end