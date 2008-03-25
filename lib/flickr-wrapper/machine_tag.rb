class Flickr::MachineTag < Flickr::Base #:nodoc
  class Invalid < StandardError; end;
  
  include Validatable
  validates_presence_of :namespace, :predicate, :value
  
  attr_accessor :namespace, :predicate, :value
  
  def initialize(namespace, predicate, value)
    @namespace, @predicate, @value = namespace, predicate, value
  end
  
  def self.list(caller)
    (Flickr::Query.new(caller.user_id).execute('flickr.tags.getListUser')/:tag).map {|tag| self.from_s tag.inner_text.to_s }.compact
  end
  
  def self.from_s(string)
    new($1, $2, $3) if string =~ /(.*)\:(.*)\=(.*)/
  end
  
  def to_s
    "#{namespace}:#{predicate}=#{value}"
  end
end