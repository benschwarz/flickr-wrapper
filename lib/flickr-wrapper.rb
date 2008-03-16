# Dependencies
require 'rubygems'
require 'flickr-rest'
require 'time'

# Namespace junkie
module Flickr; end

# Classes
%w(base photoset photo tag machine_tag).each {|r| require File.join(File.dirname(__FILE__), 'flickr-wrapper', r)}