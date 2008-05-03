class Flickr::PhotoSet < Flickr::Base
  attr_accessor :id, :title, :description, :photo_count
  attr_reader :user_id
  
  def initialize id, title, description, photo_count
    @id, @title, @description, @photo_count = id, title, description, photo_count
  end
  
  # Class methods require scope of the user, it is to be sent into the method
  def self.list caller
    query = Flickr::Query.new caller.user_id
    parse(query.execute('flickr.photosets.getList'))
  end
  
  # Get information regarding set by searching with the set's ID
  def self.find caller, id
    # Keep scope of the user that made the call
    @user_id = caller.user_id
    
    query = Flickr::Query.new(@user_id).execute('flickr.photosets.getInfo', :photoset_id => id)
    # Find should return a single entity
    parse(query).first
  end
  
  # Get the photos within a set 
  # Queries:
  # > photosets.getPhotos (1 call)
  # > Photo.find ID (n calls)
  def photos
    (Flickr::Query.new(@user_id).execute('flickr.photosets.getPhotos', :photoset_id => id)/:photo).map do |photo|
      Flickr::Photo.find @user_id, photo[:id]
    end
  end
  
  private 
  def self.parse collection
    photosets = (collection/:photoset)
    photosets.empty? ? [] : photosets.map do |set|
      new(set[:id], (set/:title).inner_text, (set/:description).inner_text, set[:photos])
    end
  end
end