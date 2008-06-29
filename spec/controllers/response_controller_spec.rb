require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ResponseController do

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
end
