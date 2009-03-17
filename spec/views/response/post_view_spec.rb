require File.dirname(__FILE__) + '/../../spec_helper'

describe "viewing an event and its responses" do

  before do
    @guest = mock_model(Response, :name => '<iframe src=""></iframe>', :attending? => true)
    @event = mock_model(Event, :name => '<script></script>', :date => '<b>date</b>', :permalink => "script-script",
      :location => '<iframe src=""></iframe>', :has_responses? => true, :valid? => true, 
      :responses => [@guest])
    assigns[:event] = @event
  end

  it "should escape HTML in event name, date and location" do
    render '/response/post'
    response.should_not have_tag("script")
    response.should_not have_tag("b")
    response.should_not have_tag("iframe")
  end
end