require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::User, "class" do
  it "should be findable by email address" do
    @user = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
    @user.should be_an_instance_of Flickr::User
  end
  
  it "should be finderable by username" do
    @user = Flickr::User.find_by_username 'bees'
    @user.should be_an_instance_of Flickr::User
  end
  
  it "should have the users' realname" do
    @user = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
    @user.realname.should eql "Ben Schwarz"
  end

  it "should be a pro" do
    @user = Flickr::User.find_by_username 'bees'
    @user.pro?.should be_true
  end
  
  it "should not be a pro" do
    @user = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
    @user.pro?.should be_false
  end
  
  it "should have a buddyicon url" do
    @user = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
    @user.buddy_icon_url.should be_kind_of String
  end
  
  # http://www.flickr.com/services/api/misc.buddyicons.html
  it "should make the buddy icon url up in the correct format" do
    # No buddy icon
    @no_icon = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
    @no_icon.buddy_icon_url.should eql "http://www.flickr.com/images/buddyicon.jpg"
    
    @icon = Flickr::User.find_by_username 'thirdglance'
    @icon.buddy_icon_url.should_not eql "http://www.flickr.com/images/buddyicon.jpg"
  end
  
  it "should not have a buddy icon" do
    @no_icon = Flickr::User.find_by_email 'ben.schwarz@gmail.com'
    @no_icon.buddy_icon?.should be_false
  end
  
  it "should have a buddy icon" do
    @icon = Flickr::User.find_by_username 'thirdglance'
    puts @icon.buddy_icon_url
    @icon.buddy_icon?.should be_true
  end
  
end