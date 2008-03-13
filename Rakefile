require 'flickr-interface'
require "rake/clean"
require "rake/gempackagetask"

spec = Gem::Specification.new do |s| 
  s.name = "flickr-wrapper"
  s.version = Flickr::Base::VERSION
  s.author = "Ben Schwarz"
  s.email = "ben@germanforblack.com"
  s.homepage = "http://germanforblack.com/"
  s.platform = Gem::Platform::RUBY
  s.summary = "A grassroots wrapper around flickr - Strictly for convenience"
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "flickr-wrapper"
  s.add_dependency("flickr-rest", ">= 0.0.1")
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

# Things that we don't want in our package
CLEAN.include ["**/.*.sw?", "pkg", "lib/*.bundle", "*.gem"]

# Windows install support
windows = (PLATFORM =~ /win32|cygwin/) rescue nil
SUDO = windows ? "" : "sudo"

desc "Install flickr-methods"
task :install => [:package] do
  sh %{#{SUDO} gem install --local pkg/flickr-wrapper-#{Flickr::Base::VERSION}.gem}
end