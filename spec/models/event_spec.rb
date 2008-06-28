require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do

  before do
    @options = { :name => "Party", :date => "some time next week", :location => "my place"}
  end

  it "should be valid" do
    Event.new(@options).should be_valid
  end

  it "should force presence of name" do
    Event.new.should have(1).error_on(:name)
  end

  it "should force presence of date" do
    Event.new.should have(1).error_on(:date)
  end

  it "should force presence of location" do
    Event.new.should have(1).error_on(:location)
  end

  it "should force uniqueness of name" do
    pending
    e1 = Event.new(@options)
    e2 = Event.new(@options)
    e1.should be_valid
    e2.should have(1).error_on(:name)
  end

  it "should reject events with reserved names" do
    e1 = Event.new(:name => "new", :date => "date", :location => "loc")
    e2 = Event.new(:name => "new", :date => "date", :location => "loc")
    e3 = Event.new(:name => "new", :date => "date", :location => "loc")
    e4 = Event.new(:name => "new", :date => "date", :location => "loc")
    e1.should have(1).error_on(:name)
    e2.should have(1).error_on(:name)
    e3.should have(1).error_on(:name)
    e4.should have(1).error_on(:name)
  end

end

describe Event, "has_responses?" do

  before do
    @event = Event.new
  end

  it "should return TRUE if event has responses" do
    @event.should_receive(:responses).and_return([mock("RSVP")])
    @event.has_responses?.should be_true
  end

  it "should return FALSE if event has no reponses" do
    @event.should_receive(:responses).and_return([])
    @event.has_responses?.should be_false
  end

  it "should return FALSE if responses returns nil" do
    @event.should_receive(:responses).and_return(nil)
    @event.has_responses?.should be_false
  end

end

describe Event, "guests method synonym" do

  it "should return responses" do
    @event = Event.new
    @event.should_receive(:responses).and_return("responses")
    @event.guests.should == "responses"
  end
end
