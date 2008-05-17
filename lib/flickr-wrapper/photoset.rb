class Flickr::PhotoSet < Flickr::Base
  attr_accessor :id, :title, :description, :photo_count
  
  def initialize id, title, description, photo_count
    @id, @title, @description, @photo_count = id, title, description, photo_count
  end
  
  # Class methods require scope of the user, it is to be sent into the method
  def self.list user_id
    query = Flickr::Query.new user_id
    parse(query.execute('flickr.photosets.getList'))
  end
  
  # Get information regarding set by searching with the set's ID
  def self.find user_id, id
    # Keep scope of the user that made the call
    @user_id = user_id
    
    query = Flickr::Query.new(@user_id).execute('flickr.photosets.getInfo', :photoset_id => id)
    # Find should return a single entity
    parse(query).first
  end
  
  # Get the photos within a set 
  # Queries:
  # > photosets.getPhotos (1 call)
  # > Photo.find ID (n calls)
  def photos
    (Flickr::Query.new(user_id).execute('flickr.photosets.getPhotos', :photoset_id => id)/:photo).parallel_map(Flickr::MAX_THREADS) do |photo|
      Flickr::Photo.find user_id, photo[:id]
    end
  end
  
  # Return a list of tags for the set
  # Queries:
  # > photosets.getPhotos (1 call)
  # > Photo.find ID (n calls)
  def tags
    tags = []
    photos.each do |photo|
      photo.tags.each do |tag|
        tags << tag.value
      end
    end
    tags.uniq
  end
  
  # Return a list of machine_tags for the set
  # Queries:
  # > photosets.getPhotos (1 call)
  # > Photo.find ID (n calls)
  def machine_tags
    tags = []
    photos.each do |photo|
      photo.machine_tags.each do |tag|
        tags << tag
      end
    end
    tags.uniq
  end
  
  # Search for photosets that have similar tags
  def similar
    sets = []
    Flickr::PhotoSet.list(user_id).each do |set|
      sets << set unless (self.tags & set.tags).empty? or set == self
    end
    sets.uniq
  end
  
  private 
  def self.parse collection
    photosets = (collection/:photoset)
    photosets.empty? ? [] : photosets.map do |set|
      new(set[:id], (set/:title).inner_text, (set/:description).inner_text, set[:photos])
    end
  end
end