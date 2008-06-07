# Dependencies
require 'rubygems'
require 'flickr-rest'
require 'time'
require 'validatable'

# Concurrency
require File.join(File.dirname(__FILE__), 'vendor', 'parallel', 'parallel.rb')

# Namespace junkie
module Flickr; end

# Classes
%w(base photoset photo tag machine_tag user).each {|r| require File.join(File.dirname(__FILE__), 'flickr-wrapper', r)}