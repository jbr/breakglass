require 'active_support'

module TestRig
  module DynamicAssertions
    def self.included(klass)
      klass.class_eval do
        alias_method_chain :method_missing, :dynamic_assertions
      end
    end
    
    def method_missing_with_dynamic_assertions(method, *args)
      if method.to_s =~ /^assert_(not_)?([a-z_]+)/
        method_name = $2.to_sym
        if args.length == 1 && args.first.respond_to?(:"#{method_name}?")
          actual = args.first.send :"#{method_name}?"
          assert $1 ? !actual : actual
          return
        elsif args.length == 2 && args.last.respond_to?(method_name)
          send :"assert_#{$1}equal", args.first, args.last.send(method_name)
          return
        end
      end

      method_missing_without_dynamic_assertions(method, *args)
    end
  end
end