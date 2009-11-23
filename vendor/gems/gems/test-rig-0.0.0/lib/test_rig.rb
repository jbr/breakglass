require 'test_rig/dynamic_assertions'
require 'test_rig/smarter_message'

module TestRig
  def self.included(klass)
    klass.class_eval do
      include TestRig::DynamicAssertions
      include TestRig::SmarterMessage
    end
  end
end
