require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Response do

  before do
    @options = { :name => "John Doe", :rsvp => true, :event_id => 1 } 
  end

  it "should be valid" do
    Response.new(@options).should be_valid
  end

  it "should force presence of name" do
    Response.new.should have(1).error_on(:name)
  end

  it "should force presence of rsvp" do
    Response.new.should have(1).error_on(:rsvp)
  end

  it "should reject responses with invalid RSVPs" do
    pending
    Response.new(@options.merge(:rsvp => "yo")).should have(1).error_on(:rsvp)
  end
end

describe Response, "attending?" do

  it "should return TRUE if guest has confirmed" do
    @response = Response.new(:rsvp => true)
    @response.attending?.should be_true
  end

  it "should return FALSE if guest has cancelled" do
    @response = Response.new(:rsvp => false)
    @response.attending?.should be_false
  end

end
