require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::Base, "class" do
  it "should list sets, photos, tags and machine_tags" do
    @flickr = Flickr::Base.new '36821533@N00'
    %w(sets photos tags machine_tags).each do |method|
      @flickr.public_methods.should include(method)
    end
  end
end

describe Flickr::Base, "convenience methods" do
  before :all do
    # my user_id
    @flickr = Flickr::Base.new '36821533@N00'
  end
  
  it "should list sets" do
    @flickr.sets.should be_an_instance_of Array
    @flickr.sets.first.should be_an_instance_of Flickr::PhotoSet
  end
  
  it "should list photos" do
    @flickr.photos.should be_an_instance_of Array
    @flickr.photos.first.should be_an_instance_of Flickr::Photo
  end
  
  it "should list tags" do
    @flickr.tags.should be_an_instance_of Array
    @flickr.tags.first.should be_an_instance_of Flickr::Tag
  end
  
  it "should list machine_tags" do
    @flickr.machine_tags.should be_an_instance_of Array
    puts @flickr.machine_tags.inspect
    @flickr.machine_tags.first.should be_an_instance_of Flickr::MachineTag
  end
end