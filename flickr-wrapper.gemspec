Gem::Specification.new do |s|
  s.name = "flickr-wrapper"
  s.version = "0.1.3"
  s.date = "2008-06-07"
  s.summary = "A grassroots wrapper for flickr"
  s.email = "ben@germanforblack.com"
  s.homepage = "http://github.com/benschwarz/flickr-wrapper"
  s.description = "A grassroots wrapper around flickr - Strictly for convenience"
  s.authors = ["Ben Schwarz"]
  s.files = ["README", "flickr-wrapper.gemspec", "lib/flickr-wrapper.rb", "lib/flickr-wrapper/base.rb", "lib/flickr-wrapper/machine_tag.rb", "lib/flickr-wrapper/photo.rb", "lib/flickr-wrapper/photoset.rb", "lib/flickr-wrapper/tag.rb", "lib/flickr-wrapper/user.rb", "lib/vendor/parallel.rb"]
  s.require_path = "lib"
  
  # Deps
  s.add_dependency("flickr-rest", ">= 0.0.1")
  s.add_dependency("validatable", ">= 1.6.7")
end