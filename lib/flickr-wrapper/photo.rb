class Flickr::Photo < Flickr::Base
  class Size < Struct.new :width, :height, :source, :url; end
  
  attr_accessor :id, :title, :description, :tags, :machine_tags, :taken, :posted, :caller
  
  def initialize(id, title, description)
    @id, @title, @description = id, title, description
  end

  def self.list(user_id)
    search(user_id)
  end
  
  # Find will grab all sizes of images, process the tags and standard attributes of a photo
  def self.find(user_id, id)
    photo_call = Flickr::Query.new(user_id).execute('flickr.photos.getInfo', :photo_id => id)
      
    # Set basic attributes
    photo = self.new(id, *%w(title description).map {|a| (photo_call/a).inner_text })
    photo.taken = Time.parse(photo_call.at(:dates)['taken'])
    photo.posted = Time.at(photo_call.at(:dates)['posted'].to_i)

    # Set tags for photo
    photo.tags = (photo_call/"tag[@machine_tag=0]").map{|tag| Flickr::Tag.new tag['raw'] }
    photo.machine_tags = (photo_call/"tag[@machine_tag=1]").map{|tag| Flickr::MachineTag.from_s tag['raw'] }

    return photo
  end
  
  # Find a collection of photos by text
  # Search options should be hashes with string values or arrays for multiple values
  def self.search(user_id, search_options={})
    parse(user_id, Flickr::Query.new(user_id).execute('flickr.photos.search', search_options))
  end
  
  def sizes
    hash = {}
    (Flickr::Query.new(user_id).execute('flickr.photos.getSizes', :photo_id => id)/:size).parallel_each(Flickr::MAX_THREADS) do |size|
      hash[size['label'].downcase.to_sym] = Size.new(*%w(width height source url).map{|a| size[a]})
    end
    hash
  end
  
  private
  # Parse applies Hpricot to the photos and maps them to a Photo class instance
  def self.parse(user_id, collection)
    photos = (collection/:photo)
    photos.empty? ? [] : photos.map do |photo|
      self.find(user_id, photo[:id])
    end
  end
end