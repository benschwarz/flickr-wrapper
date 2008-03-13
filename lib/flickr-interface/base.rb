class Flickr::Base
  attr_reader :user_id
  
  def initialize(user_id)
    @user_id = user_id
  end

  # Add some convenience class methods, lovley and general; sets, photos, tags and machine tags
  
  # List all photo sets
  def sets
    Flickr::PhotoSet.list(self)
  end
  
  # This is a cheat, we're just going to search with no params.
  # Maximum amount of photos flickr will let me return is 500
  def photos
    Flickr::Photo.list(self)
  end
  
  # List all tags
  def tags
    Flickr::Tag.list(self)
  end
  
  # List all machine tags
  def machine_tags
    Flickr::MachineTag.list(self)
  end
end
