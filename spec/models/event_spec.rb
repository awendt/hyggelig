require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do

  before do
    @options = { :name => "Party", :date => "some time next week", :location => "my place"}
  end

  it "should be valid" do
    Event.new(@options).should be_valid
  end
end
