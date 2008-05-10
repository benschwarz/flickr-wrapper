class Flickr::Tag < Flickr::Base
  attr_accessor :value
  
  def initialize(tag)
    @value = tag
  end
  
  def self.list(caller)
    (Flickr::Query.new(caller.user_id).execute('flickr.tags.getListUser')/:tag).map { |tag| 
      self.new(tag.inner_text.to_s) if tag.inner_text.to_s =~ /^([a-zA-Z0-9_-]+)$/
    }.compact
  end
end