# Using openuri-memcached so the spec run quickly!
require 'openuri_memcached'

# Enable caching
OpenURI::Cache.enable!
OpenURI::Cache.expiry = 3600

# Require the library
require File.join(File.dirname(__FILE__), '..', 'lib', 'flickr-wrapper')
