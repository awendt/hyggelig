require 'spec_helper'

describe EventsController do

  it_should_prevent_modifications

  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs)
  end

  describe "GET index" do
    it "assigns all events as @events" do
      pending "action needs authentication"
      Event.stub(:find).with(:all).and_return([mock_event])
      get :index
      assigns[:events].should == [mock_event]
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      Event.stub(:find_by_permalink).with("my-party").and_return(mock_event)
      get :show, :permalink => "my-party"
      assigns[:event].should equal(mock_event)
    end

    it "flashes and redirects to event/new if no event is found by permalink" do
      Event.should_receive(:find_by_permalink).with("foo").and_return(nil)
      get :show, :permalink => "foo"
      flash[:error].should_not be_nil
      response.should redirect_to(root_path)
    end

    it "renders the 'show.html' template if event is found" do
      Event.should_receive(:find_by_permalink).with("bar").and_return(mock_event(:replies => [mock_model(Reply)]))
      get :show, :permalink => "bar"
      flash[:notice].should be_nil
      response.should render_template('events/show')
    end

    it "renders the 'feed.rxml' template for :rss format if event is found" do
      Event.should_receive(:find_by_permalink).with("bar").and_return(mock_event(:replies => [mock_model(Reply)]))
      get :show, :permalink => "bar", :format => 'rss'
      flash[:notice].should be_nil
      response.should render_template('events/feed')
    end
  end

  describe "GET new" do
    it "assigns a new event as @event" do
      Event.stub(:new).and_return(mock_event)
      get :new
      assigns[:event].should equal(mock_event)
    end

    it "render without flash" do
      get :new
      flash[:notice].should be_nil
    end
  end

  describe "GET edit" do
    it "assigns the requested event as @event" do
      pending "action needs authentication"
      Event.stub(:find).with("37").and_return(mock_event)
      get :edit, :id => "37"
      assigns[:event].should equal(mock_event)
    end
  end

  describe "POST create" do

    let(:event_attrs) { { :name => "My Party", :date => "now", :location => "here" } }
    let(:params) { {:locale => '', :event => {:these => 'params'}} }

    describe "with valid params" do
      it "assigns a newly created event as @event" do
        Event.stub(:new).with({'these' => 'params'}).and_return(mock_event(:save => true, :permalink => 'foo'))
        post :create, params
        assigns[:event].should equal(mock_event)
      end

      it "redirects to the created event" do
        Event.stub(:new).and_return(mock_event(:save => true, :permalink => 'asdf'))
        post :create, params.merge(:event => {})
        response.should redirect_to(permalink_path(:permalink => 'asdf'))
      end

      it "saves the event" do
        lambda { post :create, params.merge(:event => event_attrs) }.should \
            change(Event, :count).from(0).to(1)
      end

      it "redirects to events/show with a notice on successful save" do
        post :create, params.merge(:event => event_attrs)
        flash[:notice_item].first.should =~ /my-party/
        response.should redirect_to(permalink_path(:permalink => 'my-party'))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        Event.stub(:new).with({'these' => 'params'}).and_return(mock_event(:save => false))
        post :create, params
        assigns[:event].should equal(mock_event)
      end

      it "re-renders the 'new' template" do
        Event.stub(:new).and_return(mock_event(:save => false))
        post :create, :event => {}
        response.should render_template('new')
      end

    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested event" do
        pending "action needs authentication"
        Event.should_receive(:find).with("37").and_return(mock_event)
        mock_event.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :event => {:these => 'params'}
      end

      it "assigns the requested event as @event" do
        pending "action needs authentication"
        Event.stub(:find).and_return(mock_event(:update_attributes => true))
        put :update, :id => "1"
        assigns[:event].should equal(mock_event)
      end

      it "redirects to the event" do
        pending "action needs authentication"
        Event.stub(:find).and_return(mock_event(:update_attributes => true, :permalink => 'asdf'))
        put :update, :id => "1"
        response.should redirect_to(permalink_url(mock_event))
      end
    end

    describe "with invalid params" do
      it "updates the requested event" do
        pending "action needs authentication"
        Event.should_receive(:find).with("37").and_return(mock_event)
        mock_event.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :event => {:these => 'params'}
      end

      it "assigns the event as @event" do
        pending "action needs authentication"
        Event.stub(:find).and_return(mock_event(:update_attributes => false))
        put :update, :id => "1"
        assigns[:event].should equal(mock_event)
      end

      it "re-renders the 'edit' template" do
        pending "action needs authentication"
        Event.stub(:find).and_return(mock_event(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested event" do
      pending "action needs authentication"
      Event.should_receive(:find).with("37").and_return(mock_event)
      mock_event.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the events list" do
      pending "action needs authentication"
      Event.stub(:find).and_return(mock_event(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(events_url)
    end
  end

  describe 'previewing the permalink' do

    it 'renders nothing on GET requests' do
      get :preview_url
      response.should_not render_template('_url_preview')
      response.should be_success
    end

    it 'renders nothing on POST requests' do
      post :preview_url
      response.should_not render_template('_url_preview')
      response.should be_success
    end

    it 'renders something on XHR requests' do
      xhr :post, :preview_url
      response.should render_template('_url_preview')
      response.should be_success
    end

  end

end
