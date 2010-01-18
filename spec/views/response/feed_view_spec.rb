require File.dirname(__FILE__) + '/../../spec_helper'

describe "viewing an event's RSS feed" do

  before do
    assigns[:event] = mock_model(Event, :name => '', :date => '', :permalink => "",
      :location => '', :replies => [])
    assigns[:guests] = []
    I18n.should_receive(:locale).any_number_of_times.and_return(:foo)
  end

  it "should set the feed language according to the locale" do
    render '/replies/feed'
    response.should have_tag("language", :text => 'foo')
  end
end