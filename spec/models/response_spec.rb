require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Response do

  before do
    @attributes = { :name => "John Doe", :rsvp => true, :event_id => 1 } 
  end

  it "should be valid" do
    Response.new(@attributes).should be_valid
  end

  it "should force presence of name" do
    Response.new.should have(1).error_on(:name)
  end

  it "should force presence of rsvp" do
    Response.new.should have(1).error_on(:rsvp)
  end

  it "should turn invalid RSVPs into false" do
    Response.new(@attributes.merge(:rsvp => "yo")).rsvp.should be_false
  end

  it "should force uniqueness of guest names for one event" do
    Response.create!(@attributes)
    Response.new(@attributes).should have(1).error_on(:name)
  end

  it "should not force uniqueness of guest names across events" do
    Response.create!(@attributes)
    Response.new(@attributes.merge(:event_id => 2)).should have(0).errors_on(:name)
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

describe Response, "number_of_guests" do
  
  it "should return 1 if no additional guests specified" do
    @response = Response.new(:name => "Me")
    @response.number_of_guests.should == 1
  end

  it "should return 2 if an additional guest specified" do
    @response = Response.new(:name => "Me +1")
    @response.number_of_guests.should == 2
  end

  it "should ignore spaces" do
    @response = Response.new(:name => "Me + 1")
    @response.number_of_guests.should == 2
  end

  it "should return 20 if an additional guest specified" do
    @response = Response.new(:name => "Me +19")
    @response.number_of_guests.should == 20
  end

end