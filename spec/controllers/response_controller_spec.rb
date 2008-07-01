require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ResponseController, "GET requests" do

  it "should redirect to event/new if no event is found by permalink" do
    get :post, :id => "foo" 
    flash[:notice].should_not be_nil
    response.should redirect_to(:controller => "event", :action => "new")
  end

  it "should render the 'post' template if event is found" do
    Event.should_receive(:find_by_permalink).and_return(mock_model(Event))
    get :post, :id => "foo"
    flash[:notice].should be_nil
    response.should render_template('post')
  end

  it "should output an RSS feed sorted chronologically, most recent first" do
    alice = mock_model(Response, :created_at => 5.minutes.ago, :name => "Alice")
    bob   = mock_model(Response, :created_at => 10.minutes.ago, :name => "Bob")
    event = mock_model(Event, :responses => [bob, alice])
    Event.should_receive(:find_by_permalink).and_return(event)
    event.should_receive(:guests_by_reverse_chron)
    get :feed
  end
end
