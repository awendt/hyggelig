require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ResponseController, "processing GET requests" do

  it "should output an RSS feed" do
    alice = mock_model(Reply, :created_at => 5.minutes.ago, :name => "Alice")
    bob   = mock_model(Reply, :created_at => 10.minutes.ago, :name => "Bob")
    event = mock_model(Event, :replies => [bob, alice])
    Event.should_receive(:find_by_permalink).and_return(event)
    get :feed
    response.should render_template('feed')
  end

end
