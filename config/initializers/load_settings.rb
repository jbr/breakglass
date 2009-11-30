path = File.expand_path File.join(RAILS_ROOT, 'config', 'breakglass.yml')
begin
  BREAKGLASS_SETTINGS = YAML::load_file path
rescue
  puts "Expected to find breakglass config in #{path}"
  exit -1
end