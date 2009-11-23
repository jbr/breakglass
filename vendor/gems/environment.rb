# DO NOT MODIFY THIS FILE
module Bundler
 file = File.expand_path(__FILE__)
 dir = File.dirname(file)

  ENV["PATH"]     = "#{dir}/../../bin:#{ENV["PATH"]}"
  ENV["RUBYOPT"]  = "-r#{file} #{ENV["RUBYOPT"]}"

  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/builder-2.1.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/builder-2.1.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/flexmock-0.8.6/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/flexmock-0.8.6/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/crack-0.1.4/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/crack-0.1.4/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/test-rig-0.0.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/test-rig-0.0.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/shoulda-2.10.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/shoulda-2.10.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/clickatell-0.7.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/clickatell-0.7.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/httparty-0.4.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/httparty-0.4.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/twilio-2.4.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/twilio-2.4.1/lib")

  @gemfile = "#{dir}/../../Gemfile"

  require "rubygems"

  @bundled_specs = {}
  @bundled_specs["builder"] = eval(File.read("#{dir}/specifications/builder-2.1.2.gemspec"))
  @bundled_specs["builder"].loaded_from = "#{dir}/specifications/builder-2.1.2.gemspec"
  @bundled_specs["flexmock"] = eval(File.read("#{dir}/specifications/flexmock-0.8.6.gemspec"))
  @bundled_specs["flexmock"].loaded_from = "#{dir}/specifications/flexmock-0.8.6.gemspec"
  @bundled_specs["crack"] = eval(File.read("#{dir}/specifications/crack-0.1.4.gemspec"))
  @bundled_specs["crack"].loaded_from = "#{dir}/specifications/crack-0.1.4.gemspec"
  @bundled_specs["test-rig"] = eval(File.read("#{dir}/specifications/test-rig-0.0.0.gemspec"))
  @bundled_specs["test-rig"].loaded_from = "#{dir}/specifications/test-rig-0.0.0.gemspec"
  @bundled_specs["shoulda"] = eval(File.read("#{dir}/specifications/shoulda-2.10.2.gemspec"))
  @bundled_specs["shoulda"].loaded_from = "#{dir}/specifications/shoulda-2.10.2.gemspec"
  @bundled_specs["clickatell"] = eval(File.read("#{dir}/specifications/clickatell-0.7.0.gemspec"))
  @bundled_specs["clickatell"].loaded_from = "#{dir}/specifications/clickatell-0.7.0.gemspec"
  @bundled_specs["httparty"] = eval(File.read("#{dir}/specifications/httparty-0.4.5.gemspec"))
  @bundled_specs["httparty"].loaded_from = "#{dir}/specifications/httparty-0.4.5.gemspec"
  @bundled_specs["twilio"] = eval(File.read("#{dir}/specifications/twilio-2.4.1.gemspec"))
  @bundled_specs["twilio"].loaded_from = "#{dir}/specifications/twilio-2.4.1.gemspec"

  def self.add_specs_to_loaded_specs
    Gem.loaded_specs.merge! @bundled_specs
  end

  def self.add_specs_to_index
    @bundled_specs.each do |name, spec|
      Gem.source_index.add_spec spec
    end
  end

  add_specs_to_loaded_specs
  add_specs_to_index

  def self.require_env(env = nil)
    context = Class.new do
      def initialize(env) @env = env && env.to_s ; end
      def method_missing(*) ; yield if block_given? ; end
      def only(*env)
        old, @only = @only, _combine_only(env.flatten)
        yield
        @only = old
      end
      def except(*env)
        old, @except = @except, _combine_except(env.flatten)
        yield
        @except = old
      end
      def gem(name, *args)
        opt = args.last.is_a?(Hash) ? args.pop : {}
        only = _combine_only(opt[:only] || opt["only"])
        except = _combine_except(opt[:except] || opt["except"])
        files = opt[:require_as] || opt["require_as"] || name
        files = [files] unless files.respond_to?(:each)

        return unless !only || only.any? {|e| e == @env }
        return if except && except.any? {|e| e == @env }

        if files = opt[:require_as] || opt["require_as"]
          files = Array(files)
          files.each { |f| require f }
        else
          begin
            require name
          rescue LoadError
            # Do nothing
          end
        end
        yield if block_given?
        true
      end
      private
      def _combine_only(only)
        return @only unless only
        only = [only].flatten.compact.uniq.map { |o| o.to_s }
        only &= @only if @only
        only
      end
      def _combine_except(except)
        return @except unless except
        except = [except].flatten.compact.uniq.map { |o| o.to_s }
        except |= @except if @except
        except
      end
    end
    context.new(env && env.to_s).instance_eval(File.read(@gemfile), @gemfile, 1)
  end
end

module Gem
  @loaded_stacks = Hash.new { |h,k| h[k] = [] }

  def source_index.refresh!
    super
    Bundler.add_specs_to_index
  end
end
