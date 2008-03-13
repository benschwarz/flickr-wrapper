require File.join(File.dirname(__FILE__), 'spec_helper')

describe Photo::Size do
  it "should respond to width, height, source, url" do
     Photo::Size.public_instance_methods.should include ('width', 'height', 'source', 'url')
  end
end