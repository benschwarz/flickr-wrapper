require File.join(File.dirname(__FILE__), 'spec_helper')

describe Flickr::MachineTag, "class" do
  it "should return self from a machine_tag string" do
    tag = Flickr::MachineTag.from_s("namespace:predicate=value")
    tag.should be_an_instance_of(Flickr::MachineTag)
    tag.namespace.should eql "namespace"
    tag.predicate.should eql "predicate"
    tag.value.should eql "value"
  end
  
  it "should convert back to a string" do
    tag_value = "namespace:predicate=value"
    tag = Flickr::MachineTag.from_s(tag_value)
    tag.to_s.should eql tag_value
  end
end