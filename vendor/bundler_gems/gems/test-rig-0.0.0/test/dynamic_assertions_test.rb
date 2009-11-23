require File.join(File.dirname(__FILE__), "test_helper")

class Entry
  def published?() false end
  def saved?() true end
  def user() "joe" end
end

class DynamicAssertionsTest < Test::Unit::TestCase
  include TestRig::DynamicAssertions

  def setup
    @entry = Entry.new
  end
  
  test "positive assertion" do
    assert_saved @entry
  end
  
  test "positive assertion failure" do
    assert_test_failure { assert_not_saved @entry }
  end
  
  test "negative assertion" do
    assert_not_published @entry
  end
  
  test "negative assertion failure" do
    assert_test_failure { assert_published @entry }
  end
  
  test "positive equality assertion" do
    assert_user "joe", @entry
  end
  
  test 'positive equality assertion failure' do
    assert_test_failure { assert_user 'sue', @entry }
  end
  
  test "negative equality assertion" do
    assert_not_user "sally", @entry
  end
  
  test 'negative equality assertion failure' do
    assert_test_failure { assert_not_user 'joe', @entry }
  end
end