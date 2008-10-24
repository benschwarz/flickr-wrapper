# Dependencies
begin
  require 'minigems'
rescue LoadError
  require 'rubygems'
end

require 'flickr-rest'
require 'time'
require 'validatable'

# Namespace junkie
module Flickr; end

# Classes
%w(base photoset photo tag machine_tag user).each {|r| require File.join(File.dirname(__FILE__), 'flickr-wrapper', r)}