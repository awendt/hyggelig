require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventController, "creating a new event" do

  before do
    @event = mock_model(Event, :permalink => "my-party")
    Event.should_receive(:new).and_return(@event)
  end

  it "should redirect to response/post with a notice on successful save" do
    @event.should_receive(:save).and_return(true)
    post :new
    flash[:notice].should =~ /#{@event.permalink}/
    response.should redirect_to(event_path(@event.permalink))
  end

  it "should re-render the new template on failed save" do
    @event.should_receive(:save).and_return(false)
    post :new
    flash[:notice].should be_nil
    response.should render_template('new')
  end

end
