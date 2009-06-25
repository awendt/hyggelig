require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ResponseController, 'generating routes' do

  it 'should work for feeds' do
    route_for(:controller => 'response', :action => 'feed', :permalink => 'my-party').should == '/feed/my-party'
  end

  it 'should work correctly for permalinks' do
    route_for(:controller => 'response', :action => 'post', :permalink => 'my-party').should == '/respond/my-party'
  end

end

describe ResponseController, 'recognizing routes' do

  it 'should work for feeds' do
    params_from(:get, '/feed/my-party').should == {:controller => 'response', :action => 'feed', :permalink => 'my-party'}
  end

  it 'should work for posting responses' do
    params_from(:post, '/respond/my-party').should == {:controller => 'response', :action => 'post', :permalink => 'my-party'}
  end

end

describe ResponseController, "processing GET requests" do

  it "should output an RSS feed" do
    alice = mock_model(Response, :created_at => 5.minutes.ago, :name => "Alice")
    bob   = mock_model(Response, :created_at => 10.minutes.ago, :name => "Bob")
    event = mock_model(Event, :responses => [bob, alice])
    Event.should_receive(:find_by_permalink).and_return(event)
    get :feed
    response.should render_template('feed')
  end

  it 'should flash and redirect to event if no event is found by permalink' do
    Event.should_receive(:find_by_permalink).with("foo").and_return(nil)
    get :feed, :permalink => "foo"
    response.should be_missing
    response.should render_template("#{RAILS_ROOT}/public/404.html")
  end

  it 'should redirect to event/view on #post' do
    get :post, :permalink => 'foo'
    response.should redirect_to('/foo')
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
      lambda { post :post, :permalink => "foo", :response => @options }.should_not change(Response, :count)
    end

    it "should flash and redirect" do
      post :post, :permalink => "foo", :response => @options
      flash[:error].should_not be_nil
      response.should redirect_to(create_path)
    end

  end

  describe "if event is found by permalink" do

    before :each do
      Event.should_receive(:find_by_permalink).with("bar").and_return(@event)
      @event.should_receive(:valid?).and_return(true)
      @event.stub!(:responses).and_return([mock_model(Response)])
      @event.stub!(:permalink).and_return("bar")
    end

    it "should save the response" do
      lambda { post :post, :permalink => "bar", :response => @options }.should change(Response, :count).from(0).to(1)
    end

    it "should flash and redirect to event page" do
      post :post, :permalink => "bar", :response => @options
      flash[:notice].should_not be_nil
      response.should redirect_to('/bar')
    end

  end

  describe "if event is found but response is invalid" do

    before :each do
      Event.should_receive(:find_by_permalink).with("bar").and_return(@event)
      @event.should_receive(:valid?).and_return(true)
      @event.stub!(:responses).and_return([mock_model(Response)])
    end

    it "should not save the response" do
      lambda { post :post, :permalink => "bar", :response => @options.merge(:rsvp => nil) }.should_not change(Response, :count)
    end

    it "should flash and render event page" do
      post :post, :permalink => "bar", :response => @options.merge(:rsvp => nil)
      flash[:notice].should be_nil
      response.should render_template('event/view')
    end

  end

end
