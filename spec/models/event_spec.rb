require 'spec_helper'

describe Event do
  before(:each) do
    @valid_attributes = {
      :name => "Party", :date => "some time next week", :location => "my place"
    }
  end

  it "should create a new instance given valid attributes" do
    Event.create!(@valid_attributes)
  end

  it "should force presence of name and a minimum on its length" do
    Event.new.should have(2).error_on(:name)
  end

  it "should force presence of date" do
    Event.new.should have(1).error_on(:date)
  end

  it "should force presence of location" do
    Event.new.should have(1).error_on(:location)
  end

  it "should force a minimum length on name" do
    Event.new(@valid_attributes.merge(:name => 'Pa')).should have(1).error_on(:name)
  end

  it "should not force uniqueness of name (permalink changes accordingly)" do
    Event.create!(@valid_attributes)
    new_event = Event.new(@valid_attributes)
    new_event.should be_valid
  end

  it "should reject events with reserved names, regardless of case" do
    Event.new(:name => "Events", :date => "date", :location => "loc").should have(1).error_on(:name)
    Event.new(:name => "Feed", :date => "date", :location => "loc").should have(1).error_on(:name)
    Event.new(:name => "rePlies", :date => "date", :location => "loc").should have(1).error_on(:name)
    Event.new(:name => "FAQ", :date => "date", :location => "loc").should have(1).error_on(:name)
    Event.new(:name => "Demo", :date => "date", :location => "loc").should have(1).error_on(:name)
    Event.new(:name => "HELP", :date => "date", :location => "loc").should have(1).error_on(:name)
    Event.new(:name => "tOUr", :date => "date", :location => "loc").should have(1).error_on(:name)
  end

  it "should create a permalink along with the event" do
    Event.find_by_permalink("party").should be_nil
    Event.create!(@valid_attributes)
    Event.find_by_permalink("party").should_not be_nil
  end

  describe "advertising for webservice" do

    it 'excludes the ID for XML representation' do
      Event.create!(@valid_attributes).to_xml.should_not =~ /<id/
    end

    it 'excludes the ID for JSON representation' do
      Event.create!(@valid_attributes).to_json.should_not =~ %r("id":)
    end
  end
end

describe Event, "has_replies?" do

  before do
    @event = Event.new
  end

  it "should return TRUE if event has replies" do
    @event.should_receive(:replies).and_return([mock("RSVP")])
    @event.has_replies?.should be_true
  end

  it "should return FALSE if event has no reponses" do
    @event.should_receive(:replies).and_return([])
    @event.has_replies?.should be_false
  end

  it "should return FALSE if replies returns nil" do
    @event.should_receive(:replies).and_return(nil)
    @event.has_replies?.should be_false
  end

end

describe Event, 'write-protecting expires_on' do

  it 'should set a default value on creation' do
    event = Event.new(:name => 'test', :date => 'test', :location => 'test', :expires_on => 1.day.ago)
    event.save
    event.expires_on.should be_future
  end

  it 'should disallow setting the value afterwards' do
    event = Event.create!(:name => 'test', :date => 'test', :location => 'test')
    event.expires_on = 1.year.ago
    event.save
    event.reload # this is necessary so the object is in sync with DB
    event.expires_on.should be_future
  end

end