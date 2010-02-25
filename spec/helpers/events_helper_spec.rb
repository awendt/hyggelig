require 'spec_helper'

describe EventsHelper do

  it "provides a link to share the event link on Facebook" do
    assigns[:event] = mock_model(Event, :permalink => 'asdf')
    helper.should_receive(:page_title).any_number_of_times.and_return("")
    CGI.should_receive("escape").any_number_of_times
    helper.link_to_facebook_share.should have_tag("a[href*=facebook.com].share.facebook")
  end

  it "provides a link to share the event link on Twitter" do
    assigns[:event] = mock_model(Event, :permalink => 'asdf')
    helper.should_receive(:page_title).any_number_of_times.and_return("")
    CGI.should_receive("escape").any_number_of_times
    helper.link_to_twitter_share.should have_tag("a[href*=twitter.com].share.twitter")
  end

end
