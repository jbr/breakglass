require 'rubygems'
$:.unshift File.instance_eval { expand_path join(dirname(__FILE__), "..", "lib") }

require 'test/unit'
require 'test_rig'
require 'flexmock'
require 'context'

class Test::Unit::TestCase
  include TestRig
end
