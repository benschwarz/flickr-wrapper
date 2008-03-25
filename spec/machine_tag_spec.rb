require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::MachineTag, "class" do
  before :all do
    # my user_id
    @flickr = Flickr::Base.new '36821533@N00'
  end

  it "should return self from a machine_tag string" do
    tag = Flickr::MachineTag.new("namespace", "predicate", "value")
    tag.should be_an_instance_of(Flickr::MachineTag)
    tag.namespace.should eql "namespace"
    tag.predicate.should eql "predicate"
    tag.value.should eql "value"
  end
  
  it "should convert back to a string" do
    tag_value = "namespace:predicate=value"
    tag = Flickr::MachineTag.new('namespace', 'predicate', 'value')
    tag.to_s.should eql tag_value
  end
  
  it "should list machine tags (in general)" do
    m_tags = Flickr::MachineTag.list(@flickr)
    m_tags.should be_an_instance_of(Array)
    m_tags.first.should be_an_instance_of(Flickr::MachineTag)
  end
  
  it "should create a class instance from a correctly formatted string" do
    #incorrect
    Flickr::MachineTag.from_s("namespace:predicate").should_not be_an_instance_of Flickr::MachineTag
    
    #correct
    Flickr::MachineTag.from_s("namespace:predicate=value").should be_an_instance_of Flickr::MachineTag
  end
end