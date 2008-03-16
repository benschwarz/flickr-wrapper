class Flickr::MachineTag < Flickr::Base #:nodoc
  # MachineTag must match this pattern, otherwise they should
  # have been deemed a Tag
  STRING_VALIDATION = /(.*)\:(.*)\=(.*)/
  
  class Invalid < StandardError; end;
  
  attr_accessor :namespace, :predicate, :value
  
  def initialize(namespace, predicate, value)
    @namespace, @predicate, @value = namespace, predicate, value

    if valid?
      return self
    else
      return false
    end
  end
  
  def self.list(caller)
    (Flickr::Query.new(caller.user_id).execute('flickr.tags.getListUser')/:tag).map do |tag| 
      self.from_s(tag.inner_text.to_s)
    end
  end
  
  def self.from_s string
    new($1, $2, $3) if string =~ STRING_VALIDATION
  end

  def valid?
    to_s =~ STRING_VALIDATION
  end  
  
  def to_s
    "#{namespace}:#{predicate}=#{value}"
  end

end