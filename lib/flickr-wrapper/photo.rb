class Flickr::Photo < Flickr::Base
  class Size < Struct.new :width, :height, :source, :url; end
  
  attr_accessor :id, :title, :description, :tags, :machine_tags, :taken, :posted
  
  def initialize(id, title, description)
    @id, @title, @description = id, title, description
  end

  def self.list(caller)
    flickr = Flickr::Query.new caller.user_id
    photos = (flickr.execute("flickr.photos.search")/:photo)
    photos.empty? ? [] : photos.map do |photo|
      self.find(caller, photo[:id])
    end
  end
  
  # Find will grab all sizes of images, process the tags and standard attributes of a photo
  def self.find(caller, id)
    photo_call = Flickr::Query.new(caller.user_id).execute('flickr.photos.getInfo', :photo_id => id)
      
    # Set basic attributes
    photo = self.new(id, *%w(title description).map {|a| (photo_call/a).inner_text })
    photo.taken = Time.parse(photo_call.at(:dates)['taken'])
    photo.posted = Time.at(photo_call.at(:dates)['posted'].to_i)

    # Set tags for photo
    photo.tags = (photo_call/"tag[@machine_tag=0]").map{|tag| Flickr::Tag.new tag['raw'] }
    photo.machine_tags = (photo_call/"tag[@machine_tag=1]").map{|tag| Flickr::MachineTag.from_s tag['raw'] }

    return photo
  end
  
  def sizes
    hash = {}
    (Flickr::Query.execute('flickr.photos.getSizes', :photo_id => id)/:size).each do |size|
      hash[size['label'].downcase.to_sym] = Flickr::Size.new(*%w(width height source url).map{|a| size[a]})
    end
    hash
  end
end