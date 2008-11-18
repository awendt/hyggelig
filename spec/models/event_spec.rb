require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do

  before do
    @attributes = { :name => "Party", :date => "some time next week", :location => "my place"}
  end

  it "should be valid" do
    Event.new(@attributes).should be_valid
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

  it "should force uniqueness of name, regardless of case" do
    Event.create!(@attributes)
    new_event = Event.new(@attributes.merge(:name => "party"))
    new_event.should have(1).error_on(:name)
  end

  it "should reject events with reserved names, regardless of case" do
    e1 = Event.new(:name => "neW", :date => "date", :location => "loc")
    e2 = Event.new(:name => "Event", :date => "date", :location => "loc")
    e3 = Event.new(:name => "Feed", :date => "date", :location => "loc")
    e4 = Event.new(:name => "resPonse", :date => "date", :location => "loc")
    e5 = Event.new(:name => "FAQ", :date => "date", :location => "loc")
    e6 = Event.new(:name => "Demo", :date => "date", :location => "loc")
    e7 = Event.new(:name => "HELP", :date => "date", :location => "loc")
    e1.should have(1).error_on(:name)
    e2.should have(1).error_on(:name)
    e3.should have(1).error_on(:name)
    e4.should have(1).error_on(:name)
    e5.should have(1).error_on(:name)
    e6.should have(1).error_on(:name)
    e7.should have(1).error_on(:name)
  end

  it "should create a permalink along with the event" do
    Event.find_by_permalink("party").should be_nil
    Event.create!(@attributes)
    Event.find_by_permalink("party").should_not be_nil
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

describe Event, "guests_by_reverse_chron method" do

  it "should return chronologically ordered responses" do
    alice = mock_model(Response, :created_at => 10.minutes.ago, :name => "Alice")
    bob   = mock_model(Response, :created_at => 5.minutes.ago, :name => "Bob")
    @event = Event.new
    @event.should_receive(:responses).and_return([alice, bob])
    @event.guests_by_reverse_chron.should == [bob, alice]
  end
end
