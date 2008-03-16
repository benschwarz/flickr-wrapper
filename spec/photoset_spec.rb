require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::PhotoSet, "class" do
  before :all do
    # my user_id
    @flickr = Flickr::Base.new '36821533@N00'
  end
  
  it "should be able to getInfo itself"
  it "should allow for searching"
  
  it "should provide a list" do
    mysets = Flickr::PhotoSet.list(@flickr)
    mysets.should be_an_instance_of(Array)
    mysets.first.should be_an_instance_of(Flickr::PhotoSet)
  end
  
  it "should be findable by id" do
    myset = Flickr::PhotoSet.find @flickr, "72157603414539843"
    myset.should be_an_instance_of(Flickr::PhotoSet)
  end
  
  it "should have a list of photos" do
    myset = Flickr::PhotoSet.find @flickr, "72157603414539843"
    photos = myset.photos
    photos.should be_an_instance_of(Array)
    photos.first.should be_an_instance_of(Flickr::Photo)
  end
  
  it "should collect tags for the photos in the set" do
    myset = Flickr::PhotoSet.find @flickr, "72157603414539843"
    tags = myset.tags
    tags.should be_an_instance_of(Array)
    tags.first.should be_an_instance_of(String)
  end
  
  it "should collect machine_tags for the photos in the set" do
    myset = Flickr::PhotoSet.find @flickr, "72157603414539843"
    tags = myset.machine_tags
    tags.should be_an_instance_of(Array)
    tags.first.should be_an_instance_of(Flickr::MachineTag)
  end
  
  it "should collect unique tags" do
    myset = Flickr::PhotoSet.find @flickr, "72157603414539843"
    tags = myset.tags
    tags.uniq.should eql tags
  end
  
  it "should know of similar sets" do
    myset = Flickr::PhotoSet.find @flickr, "72157603414539843"
    myset.similar.should be_an_instance_of(Array)
  end
end