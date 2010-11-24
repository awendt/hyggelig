require 'spec_helper'

describe EventsHelper do
  let(:event) { mock_model(Event, :permalink => 'asdf') }

  before do
    helper.stub(:page_title).and_return("")
    CGI.stub("escape").any_number_of_times
  end

  it "provides a link to share the event link on Facebook" do
    helper.link_to_facebook_share_for(event).should \
        have_selector("a[href*=facebook].share.facebook")
  end

  it "provides a link to share the event link on Twitter" do
    helper.link_to_twitter_share_for(event).should \
        have_selector("a[href*=twitter].share.twitter")
  end

end
