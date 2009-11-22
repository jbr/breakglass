require File.instance_eval { expand_path join(dirname(__FILE__), 'test_helper') }
require 'action_controller'
require 'resourceful_loader'

class Object
  def eigenclass
    class << self; self; end
  end
end

class BlankController < ActionController::Base
  include ResourcefulLoader
end

class Foo; end

class ResourcefulLoaderTest < Test::Unit::TestCase
  include FlexMock::TestCase

  context "A blank AC:B" do
    should 'have a #load_resource class method' do
      assert BlankController.respond_to?(:load_resource)
    end
  end
  
  context 'With a controller that has a basic load_resource macro' do
    before do
      @controller = BlankController.new
      @controller.eigenclass.load_resource :foo
    end

    should 'append #load_foo on the before filters' do
      assert @controller.eigenclass.before_filters.include?(:load_foo)
    end
    
    should 'define #load_foo' do
      assert @controller.private_methods.include?("load_foo")
    end
    
    context 'on call to load_foo' do
      should 'call Foo.find_by_id(params[:foo])' do
        flexmock(@controller, :params => {'foo_id' => 'bar'})
        flexmock(Foo).should_receive(:find_by_id).once.with('bar').and_return('wibble')
        @controller.send :load_foo
        assert_equal 'wibble', @controller.instance_variable_get(:@foo)
      end
    end
  end
  
  context 'With a controller that specifies some options' do
    before do
      @controller = BlankController.new
      @filter_options = {"only" => [:some, :method, :names]}
      @controller.eigenclass.load_resource :foo, @filter_options.merge(:by => :id, :method => :find_by_searching)
    end
    
    should 'pass the filter options except :by and :method through to before_filter' do
      filter = @controller.eigenclass.filter_chain.detect {|filter| filter.method == :load_foo}
      assert_options @filter_options, filter
    end
    
    should 'call the method with params[options[:by]]' do
      flexmock(@controller, :params => {:id => 'bar'})
      flexmock(Foo).should_receive(:find_by_searching).once.with('bar').and_return('wibble')
      @controller.send :load_foo
      assert_equal 'wibble', @controller.instance_variable_get(:@foo)
    end
  end
  
  context 'with a block' do
    before do
      @controller = BlankController.new
      @controller.eigenclass.load_resource :foo do |foo_param|
        "test response #{foo_param}"
      end
    end
    
    context 'load_foo' do
      should 'eval the block with params["foo_id"]' do
        flexmock(@controller, :params => {'foo_id' => 'bar'})
        @controller.send :load_foo
        assert_equal 'test response bar', @controller.instance_variable_get(:@foo)
      end
    end
  end
end
