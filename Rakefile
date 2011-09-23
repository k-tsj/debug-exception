ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup'
require "bundler/gem_tasks"

require "rake/extensiontask"
Rake::ExtensionTask.new("debug_exception", DebugExceptionSpec) do |ext|
end
