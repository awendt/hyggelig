require 'spec_helper'

describe "/events/show.html.erb" do
  include EventsHelper
  before(:each) do
    assigns[:event] = @event = stub_model(Event,
      :name => "value for name",
      :date => "value for date",
      :location => "value for location",
      :expires_on => 2.days.from_now,
      :permalink => 'asdf'
    )
    assigns[:reply] = @reply = stub_model(Reply)
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ date/)
    response.should have_text(/value\ for\ location/)
  end

  it "should set the feed language according to the locale" do
    @event.should_receive(:permalink).and_return("permalink")
    I18n.should_receive(:locale).any_number_of_times.and_return(:foo)
    render '/events/feed.rxml'
    response.should have_tag("language", :text => 'foo')
  end
end

describe "/events/show.html.erb" do
  include EventsHelper
  before(:each) do
    assigns[:event] = @event = stub_model(Event,
      :name => '<script></script>',
      :date => "<b>date</b>",
      :location => '<iframe src=""></iframe>',
      :expires_on => 2.days.from_now,
      :permalink => 'asdf'
    )
    assigns[:reply] = @reply = stub_model(Reply)
  end

  it "escapes HTML in event name, date and location" do
    render
    response.should_not have_tag("script")
    response.should_not have_tag("b")
    response.should_not have_tag("iframe")
  end

end