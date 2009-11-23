require File.join(File.dirname(__FILE__), "test_helper")

class SmarterMessageTest < Test::Unit::TestCase
  include TestRig::SmarterMessage
  
  test "smarter message includes the relevent snippet" do
    a, b = 'foo', 'bar'
    e = assert_test_failure { assert_equal a, b }
    [
      "<\"foo\"> expected but was\n<\"bar\">.",
      "a, b = 'foo', 'bar'",
      "-->  8",
      "assert_equal a, b"
    ].each {|snippet| assert_match snippet, e.message}
  end

  test "backtrace includes only relevant lines" do
    e = assert_test_failure { assert false }
    [
      "backtrace includes only relevant lines",
      "#{__FILE__}:18"
    ].each {|snippet| assert_match snippet, e.backtrace.first}
  end
  
  test 'with four context lines' do
    TestRig::SmarterMessage.context_lines = context = 4
    e = assert_test_failure { assert false }
    context_output = e.message.split("\n").select{|line| line =~ /^(-->)?\s+[0-9]+:/}
    
    assert_equal context * 2 + 1, context_output.size
    assert_match "test 'with four context lines", context_output[2]
    assert_match /-->.+assert false/, context_output[context]
    TestRig::SmarterMessage.context_lines = 2
  end
end



