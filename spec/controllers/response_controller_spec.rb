require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ResponseController, "processing GET requests" do

  it "should flash and redirect to event/new if no event is found by permalink" do
    Event.should_receive(:find_by_permalink).with("foo").and_return(nil)
    get :post, :id => "foo"
    flash[:notice].should_not be_nil
    response.should redirect_to(:controller => "event", :action => "new")
  end

  it "should render the 'post' template if event is found" do
    Event.should_receive(:find_by_permalink).with("bar").and_return(mock_model(Event))
    get :post, :id => "bar"
    flash[:notice].should be_nil
    response.should render_template('post')
  end

  it "should output an RSS feed ordered in reverse chronology (most recent first)" do
    alice = mock_model(Response, :created_at => 5.minutes.ago, :name => "Alice")
    bob   = mock_model(Response, :created_at => 10.minutes.ago, :name => "Bob")
    event = mock_model(Event, :responses => [bob, alice])
    Event.should_receive(:find_by_permalink).and_return(event)
    event.should_receive(:guests_by_reverse_chron)
    get :feed
  end

end

describe ResponseController, "processing POST requests" do

  before do
    @event = mock_model(Event)
  end

  describe "if event is not found" do

    before :each do
      Event.should_receive(:find_by_permalink).with("foo").and_return(nil)
    end

    it "should not save the response" do
      lambda { post :post, :id => "foo", :response => { :name => "bob", :rsvp => false} }.should_not change(Response, :count)
    end

    it "should flash and redirect" do
      post :post, :id => "foo", :response => { :name => "bob", :rsvp => false}
      flash[:notice].should_not be_nil
      response.should redirect_to(home_path)
    end

  end

  describe "if event is found by permalink" do

    before :each do
      Event.should_receive(:find_by_permalink).with("bar").and_return(@event)
      @event.should_receive(:valid?).and_return(true)
    end

    it "should save the response" do
      lambda { post :post, :id => "bar", :response => { :name => "alice", :rsvp => true } }.should change(Response, :count).from(0).to(1)
    end

    it "should not flash and render anew" do
      post :post, :id => "bar", :response => { :name => "alice", :rsvp => true }
      flash[:notice].should be_nil
      response.should render_template('post')
    end

  end

  describe "if event is found but response is invalid" do

    before :each do
      Event.should_receive(:find_by_permalink).with("bar").and_return(@event)
      @event.should_receive(:valid?).and_return(true)
    end

    it "should not save the response" do
      lambda { post :post, :id => "bar", :response => { :name => "alice" } }.should_not change(Response, :count)
    end

    it "should flash and render anew" do
      post :post, :id => "bar", :response => { :name => "alice" }
      flash[:notice].should_not be_nil
      response.should render_template('post')
    end

  end

end
