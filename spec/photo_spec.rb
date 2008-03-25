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
    Flickr::Photo.public_instance_methods.should include "tags"
    tags = Flickr::Photo.find(@flickr, "252091410").tags
    tags.should be_an_instance_of(Array)
    tags.first.should be_an_instance_of(Flickr::Tag)
  end
  
  it "should have a taken time" do
    @photo = Flickr::Photo.find(@flickr, "252091410")
    @photo.taken.should be_an_instance_of(Time)
  end
  
  it "should have machine_tags" do
    Flickr::Photo.public_instance_methods.should include "machine_tags"
    machine_tags = Flickr::Photo.find(@flickr, "252091410").machine_tags
    machine_tags.should be_an_instance_of(Array)
    machine_tags.first.should be_an_instance_of(Flickr::MachineTag)
    machine_tags.first.namespace.should eql "flickrfolio"
    machine_tags.first.predicate.should eql "test"
    machine_tags.first.value.should eql "spec"
  end
  
  it "should have an array of hashes that contain Size class instances" do
    sizes = Flickr::Photo.search(@flickr, "spec").first.sizes
    sizes.should be_an_instance_of(Hash)
    sizes[:thumbnail].should be_an_instance_of(Flickr::Photo::Size)
  end
end

describe "Searching" do
  it "should be empty when no search is met" do 
    search = Flickr::Photo.search("null")
    search.should be_an_instance_of(Array)
    search.should be_empty
  end
  
  it "should return an array of its self" do
    search = Flickr::Photo.search("spec")
    search.should be_an_instance_of(Array)
    search.first.should be_an_instance_of(Flickr::Photo)
  end
  
  it "should find a Flickr::Photo by id" do
    Flickr::Photo = Flickr::Photo.find "252091410"
    Flickr::Photo.should be_an_instance_of(Flickr::Photo)
  end
  
  it "should be able to find Flickr::Photos by tags only" do
    search = Flickr::Photo.search(:tags => ["street"])
    search.should be_an_instance_of(Array)
    search.first.should be_an_instance_of(Flickr::Photo)
  end
end