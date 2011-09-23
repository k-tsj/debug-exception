# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "debug-exception/version"

DebugExceptionSpec = Gem::Specification.new do |s|
  s.name        = "debug-exception"
  s.version     = Debug::Exception::VERSION
  s.authors     = ["Kazuki Tsujimoto"]
  s.email       = ["kazuki@callcc.net"]
  s.homepage    = "https://github.com/k-tsj/debug-exception"
  s.summary     = %q{Helps you to debug an exception.}
  s.description = %w{
    Automatically start the REPL on an exception to debug.
    Note that because of debugger API limitation of Ruby,
    this library does not work in some cases.
  }.join(' ')

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths    = ["lib"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.rdoc_options     = ["--main", "README.rdoc"]

  s.extensions << "ext/debug_exception/extconf.rb"

  s.add_development_dependency "rake-compiler"
end unless defined? DebugExceptionSpec # suppres "already initialized constant" warnings

DebugExceptionSpec
