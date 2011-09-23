ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup'
require "bundler/gem_tasks"

require "rake/extensiontask"
Rake::ExtensionTask.new("debug_exception", DebugExceptionSpec) do |ext|
end

require "rake/testtask"
task :default => :test
task :test => :compile
Rake::TestTask.new do |t|
  t.libs << "lib"
  t.test_files = FileList["test/test_*.rb"]
end
