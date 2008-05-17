require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::User, "class" do
  it "should be findable by email address" do
    @user = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
    @user.should be_an_instance_of Flickr::User
  end
  
  it "should be finderable by username" do
    @user = Flickr::User.find_by_username 'thomashawk'
    @user.should be_an_instance_of Flickr::User
  end
  
  it "should have the users' realname" do
    @user = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
    @user.realname.should eql "Ben Schwarz"
  end

  # it "should be a pro" do
  #   @user = Flickr::User.find_by_username 'thomashawk'
  #   @user.pro?.should be_true
  # end
  
  # it "should not be a pro" do
  #   @user = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
  #   @user.pro?.should be_false
  # end
  
end