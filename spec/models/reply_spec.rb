require 'spec_helper'

describe Reply do
  before(:each) do
    @valid_attributes = {
       :name => "John Doe", :rsvp => true, :event_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Reply.create!(@valid_attributes)
  end

  it "should force presence of name" do
    Reply.new.should have(1).error_on(:name)
  end

  it "should force presence of rsvp" do
    Reply.new.should have(1).error_on(:rsvp)
  end

  it "should turn invalid RSVPs into false" do
    Reply.new(@valid_attributes.merge(:rsvp => "yo")).rsvp.should be_false
  end

  it "should force uniqueness of guest names for one event" do
    Reply.create!(@valid_attributes)
    Reply.new(@valid_attributes).should have(1).error_on(:name)
  end

  it "should force uniqueness of guest names for one event, regardless of case" do
    Reply.create!(@valid_attributes.merge(:name => @valid_attributes[:name].capitalize))
    Reply.new(@valid_attributes).should have(1).error_on(:name)
  end

  it "should not force uniqueness of guest names across events" do
    Reply.create!(@valid_attributes)
    Reply.new(@valid_attributes.merge(:event_id => 2)).should have(0).errors_on(:name)
  end
end

describe Reply, "attending?" do

  it "should return TRUE if guest has confirmed" do
    @reply = Reply.new(:rsvp => true)
    @reply.attending?.should be_true
  end

  it "should return FALSE if guest has cancelled" do
    @reply = Reply.new(:rsvp => false)
    @reply.attending?.should be_false
  end

end

describe Reply, "number_of_guests" do

  it "should return 1 if no additional guests specified" do
    @reply = Reply.new(:name => "Me")
    @reply.number_of_guests.should == 1
  end

  it "should return 2 if an additional guest specified" do
    @reply = Reply.new(:name => "Me +1")
    @reply.number_of_guests.should == 2
  end

  it "should ignore spaces" do
    @reply = Reply.new(:name => "Me + 1")
    @reply.number_of_guests.should == 2
  end

  it "should return 20 if an additional guest specified" do
    @reply = Reply.new(:name => "Me +19")
    @reply.number_of_guests.should == 20
  end

end