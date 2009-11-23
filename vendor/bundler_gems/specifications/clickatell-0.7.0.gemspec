# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{clickatell}
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Luke Redpath"]
  s.date = %q{2009-10-06}
  s.default_executable = %q{sms}
  s.email = %q{luke@lukeredpath.co.uk}
  s.executables = ["sms"]
  s.extra_rdoc_files = ["RDOC_README.txt", "History.txt", "License.txt"]
  s.files = ["History.txt", "License.txt", "RDOC_README.txt", "README.textile", "bin/sms", "spec/api_spec.rb", "spec/command_executor_spec.rb", "spec/hash_ext_spec.rb", "spec/response_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "lib/clickatell/api/command.rb", "lib/clickatell/api/command_executor.rb", "lib/clickatell/api/error.rb", "lib/clickatell/api/message_status.rb", "lib/clickatell/api.rb", "lib/clickatell/response.rb", "lib/clickatell/utility/options.rb", "lib/clickatell/utility.rb", "lib/clickatell/version.rb", "lib/clickatell.rb", "lib/core-ext/hash.rb"]
  s.homepage = %q{http://clickatell.rubyforge.org}
  s.rdoc_options = ["--main", "RDOC_README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{clickatell}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Ruby interface to the Clickatell SMS gateway service.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
