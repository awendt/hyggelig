require File.dirname(__FILE__) + '/../../spec_helper'

describe "viewing an event and its responses" do

  before do
    @resp = mock_model(Response, :name => '<iframe src=""></iframe>', :attending? => true, :rsvp => true)
    @event = mock_model(Event, :name => '<script></script>', :date => '<b>date</b>', :permalink => "script-script",
      :location => '<iframe src=""></iframe>', :has_responses? => true, :valid? => true,
      :responses => [@resp], :expires_on => 1.day.from_now)
    assigns[:event] = @event
    assigns[:response] = @resp
  end

  it "should escape HTML in event name, date and location" do
    render '/event/view'
    response.should_not have_tag("script")
    response.should_not have_tag("b")
    response.should_not have_tag("iframe")
  end
end
