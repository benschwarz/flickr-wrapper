class Flickr::PhotoSet < Flickr::Base
  attr_accessor :id, :title, :description, :photo_count
  
  def initialize(id, title, description, photo_count)
    @id, @title, @description, @photo_count = id, title, description, photo_count
  end
  
  # Class methods require scope of the user, it is to be sent into the method
  def self.list(caller)
    flickr = Flickr::Query.new caller.user_id
    (flickr.execute('flickr.photosets.getList')/:photosets).map do |set|
      self.new(set[:id], set[:title], (set/:description).inner_html, set[:photos])
    end
  end
  
  # Get information regarding set by searching with the set's ID
  def self.find caller, id
    query = Flickr::Query.new(caller.user_id).execute('flickr.photosets.getInfo', :photoset_id => id)
    photosets = (query/:photoset)
    photosets.empty? ? [] : photosets.map do |set|
      self.new(set[:id], (set/:title).inner_text, (set/:description).inner_text, set[:photos])
    end
    
    return photosets
  end
end