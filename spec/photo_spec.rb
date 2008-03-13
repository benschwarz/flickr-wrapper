require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::Photo, "class" do
  before :all do
    # my user_id
    @flickr = Flickr::Base.new '36821533@N00'
  end
  
  it "should be able to get more info about itself (getInfo)"
  it "should have a taken date"
  it "should have a posted date"
  
  it "should list all photos"
  
  it "should have tags" do
    Photo.public_instance_methods.should include "tags"
    tags = Photo.find("252091410").tags
    tags.should be_an_instance_of(Array)
    tags.first.should be_an_instance_of(Tag)
  end
  
  it "should have a taken time" do
    photo = Photo.find("252091410")
    photo.taken.should be_an_instance_of(Time)
  end
  
  it "should have machine_tags" do
    Photo.public_instance_methods.should include "machine_tags"
    machine_tags = Photo.find("252091410").machine_tags
    machine_tags.should be_an_instance_of(Array)
    machine_tags.first.should be_an_instance_of(MachineTag)
    machine_tags.first.namespace.should eql "flickrfolio"
    machine_tags.first.predicate.should eql "test"
    machine_tags.first.value.should eql "spec"
  end
  
  it "should have an array of hashes that contain Size class instances" do
    sizes = Photo.search("spec").first.sizes
    sizes.should be_an_instance_of(Hash)
    sizes[:thumbnail].should be_an_instance_of(Photo::Size)
  end
end

describe "Searching" do
  it "should be empty when no search is met" do 
    search = Photo.search("null")
    search.should be_an_instance_of(Array)
    search.should be_empty
  end
  
  it "should return an array of its self" do
    search = Photo.search("spec")
    search.should be_an_instance_of(Array)
    search.first.should be_an_instance_of(Photo)
  end
  
  it "should find a photo by id" do
    photo = Photo.find "252091410"
    photo.should be_an_instance_of(Photo)
  end
  
  it "should be able to find photos by tags only" do
    search = Photo.search(:tags => ["street"])
    search.should be_an_instance_of(Array)
    search.first.should be_an_instance_of(Photo)
  end
end