require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventController, "processing GET requests" do

  it "should render event/new on /" do
    get :new
    response.should render_template('new')
    flash[:notice].should be_nil
  end
end

describe EventController, "creating a new event" do

  before do
    @options = { :name => "My Party", :date => "now", :location => "here" }
  end

  it "should save the event if valid" do
    lambda { post :new, :event => @options }.should change(Event, :count).from(0).to(1)
  end

  it "should redirect to response/post with a notice on successful save" do
    post :new, :event => @options
    flash[:notice].should =~ /my-party/
    response.should redirect_to(event_path("my-party"))
  end

  it "should not save the event if invalid" do
    lambda { post :new, :event => @options.merge(:name => nil) }.should_not change(Event, :count)
  end

  it "should re-render the 'new' template on failed save" do
    post :new, :event => @options.merge(:name => nil)
    flash[:notice].should be_nil
    response.should render_template('new')
  end

  it "should pass the params to event" do
    Event.should_receive(:new).with(@options.stringify_keys).and_return(@event)
    @event.stub!(:save)
    post :new, :event => @options
  end

end
