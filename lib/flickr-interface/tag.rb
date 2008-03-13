class Flickr::Tag < Flickr::Base
  attr_accessor :value
  
  def initialize(tag)
    @value = tag
  end
  
  def self.list(caller)
    (Flickr::Query.new(caller.user_id).execute('flickr.tags.getListUser')/:tag).map do |tag| 
      self.new(tag.inner_text.to_s)
    end
  end
end