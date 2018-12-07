clearing :on

guard :rspec, cmd: 'bundle exec rspec' do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
