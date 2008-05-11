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
  
  #
  # ==== Instance methods
  #
  
  def realname
    get_info.at(:realname).inner_text
  end
  
  # The psyical location string as entered in flickr
  def location
    get_info.at(:location).inner_text || "Unknown"
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
end