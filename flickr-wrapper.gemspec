Gem::Specification.new do |s|
  s.name = "flickr-wrapper"
  s.version = "0.1.0"
  s.date = "2008-05-10"
  s.summary = "A grassroots wrapper for flickr"
  s.email = "ben@germanforblack.com"
  s.homepage = "http://github.com/benschwarz/flickr-wrapper"
  s.description = "A grassroots wrapper around flickr - Strictly for convenience"
  s.authors = ["Ben Schwarz"]
  s.files = ["README", "flickr-wrapper.gemspec", "lib/flickr-wrapper.rb", "lib/flickr-wrapper/base.rb", "lib/flickr-wrapper/machine_tag.rb", "lib/flickr-wrapper/photo.rb", "lib/flickr-wrapper/photoset.rb", "lib/flickr-wrapper/tag.rb", "lib/flickr-wrapper/user.rb"]
  s.require_path = "lib"
  
  # Deps
  s.add_dependency("flickr-rest", ">= 0.0.1")
end