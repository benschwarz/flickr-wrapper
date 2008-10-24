class Flickr::User < Flickr::Base
  attr_accessor :username, :nsid
  
  def initialize username, nsid
    @username, @nsid = username, nsid
  end
  
  #
  # ==== Class methods
  #
  
  def self.find_by_email email
    result = Flickr::Query.new('').execute('flickr.people.findByEmail', :find_email => email)
    return Flickr::User.new(result.at(:username).inner_text, result.at(:user)['nsid'])
  end
  
  def self.find_by_username username
    result = Flickr::Query.new('').execute('flickr.people.findByUsername', :username => username)
    return Flickr::User.new(result.at(:username).inner_text, result.at(:user)['nsid'])
  end
  
  #
  # ==== Instance methods
  #
  
  def realname
    get_info.at(:realname).inner_text
  end
  
  # The location string as entered in flickr
  def location
    get_info.at(:location).inner_text || "Unknown"
  end
  
  # has the user shelled out for flickr-pro account?
  def pro?
    (get_info.at(:person)["ispro"] == "1") ? true : false 
  end
  
  # Do they have a buddy icon or not?
  def buddy_icon?
    (icon_server > 0) ? true : false 
  end
  
  def buddy_icon_url
    buddy_icon? ? "http://farm#{icon_farm}.static.flickr.com/#{icon_server}/buddyicons/#{nsid}.jpg" : "http://www.flickr.com/images/buddyicon.jpg"
  end
  
  #
  # ==== Private methods
  #
  
  private 
    # Get info for the user, once and once only
    def get_info
      @info = Flickr::Query.new(@nsid).execute('flickr.people.getInfo', :user_id => nsid) unless @info
      @info
    end
    
    def icon_server
      get_info.at(:person)["iconserver"].to_i
    end
    
    def icon_farm
      get_info.at(:person)["iconfarm"].to_i
    end
end