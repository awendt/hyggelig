require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ResponseController, "processing GET requests" do

  it "should flash and redirect to event/new if no event is found by permalink" do
    Event.should_receive(:find_by_permalink).with("foo").and_return(nil)
    get :post, :id => "foo"
    flash[:error].should_not be_nil
    response.should redirect_to(create_path)
  end

  it "should render the 'post' template if event is found" do
    Event.should_receive(:find_by_permalink).with("bar").and_return(mock_model(Event, :guests_by_reverse_chron => [mock_model(Response)]))
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

  it 'should flash and redirect to event if no event is found by permalink' do
    Event.should_receive(:find_by_permalink).with("foo").and_return(nil)
    get :feed, :id => "foo"
    response.should be_missing
    response.should render_template("#{RAILS_ROOT}/public/404.html")
  end

end

describe ResponseController, "processing POST requests" do

  before do
    @event = mock_model(Event)
    @options = { :name => "bob", :rsvp => false}
  end

  it "should pass the params to Response when creating an instance" do
    Response.should_receive(:new).with(@options.stringify_keys).and_return(@response)
    @response.stub!(:save)
    @response.stub!(:event=)
    post :post, :response => @options
  end

  describe "if event is not found" do

    before :each do
      Event.should_receive(:find_by_permalink).with("foo").and_return(nil)
    end

    it "should not save the response" do
      lambda { post :post, :id => "foo", :response => @options }.should_not change(Response, :count)
    end

    it "should flash and redirect" do
      post :post, :id => "foo", :response => @options
      flash[:error].should_not be_nil
      response.should redirect_to(create_path)
    end

  end

  describe "if event is found by permalink" do

    before :each do
      Event.should_receive(:find_by_permalink).with("bar").and_return(@event)
      @event.should_receive(:valid?).and_return(true)
      @event.stub!(:guests_by_reverse_chron).and_return([mock_model(Response)])
    end

    it "should save the response" do
      lambda { post :post, :id => "bar", :response => @options }.should change(Response, :count).from(0).to(1)
    end

    it "should not flash and render anew" do
      post :post, :id => "bar", :response => @options
      flash[:notice].should_not be_nil
      response.should render_template('post')
    end

  end

  describe "if event is found but response is invalid" do

    before :each do
      Event.should_receive(:find_by_permalink).with("bar").and_return(@event)
      @event.should_receive(:valid?).and_return(true)
      @event.stub!(:guests_by_reverse_chron).and_return([mock_model(Response)])
    end

    it "should not save the response" do
      lambda { post :post, :id => "bar", :response => @options.merge(:rsvp => nil) }.should_not change(Response, :count)
    end

    it "should flash and render anew" do
      post :post, :id => "bar", :response => @options.merge(:rsvp => nil)
      flash[:notice].should be_nil
      response.should render_template('post')
    end

  end

end
