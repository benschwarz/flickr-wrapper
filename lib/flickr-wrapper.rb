# Dependencies
begin
  require 'minigems'
rescue LoadError
  require 'rubygems'
end

require 'flickr-rest'
require 'time'
require 'validatable'

# Concurrency
require File.join(File.dirname(__FILE__), 'vendor', 'parallel.rb')

# Namespace junkie
module Flickr
  MAX_THREADS = 50
end

# Classes
%w(base photoset photo tag machine_tag user).each {|r| require File.join(File.dirname(__FILE__), 'flickr-wrapper', r)}