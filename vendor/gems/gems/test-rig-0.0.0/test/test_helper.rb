require 'rubygems'
$:.unshift File.instance_eval { expand_path join(dirname(__FILE__), "..", "lib") }

require 'active_support'
require 'test/unit'
require 'test_rig'

class Test::Unit::TestCase
  def self.test(name, &blk) define_method(:"test #{name}", &blk) end
  def assert_test_failure(&blk)
    assert_raise Test::Unit::AssertionFailedError, &blk
  end
end
