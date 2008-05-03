require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::Tag, "class" do
  before do
    @flickr = Flickr::Base.new '36821533@N00'
  end
  
  it "should list all tags" do
    tags = Flickr::Tag.list(@flickr)
    tags.should(be_an_instance_of(Array))
    tags.should(be_an_instance_of(Flickr::Tag))
  end
end