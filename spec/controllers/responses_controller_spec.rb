require 'spec_helper'

describe ResponsesController do

  def mock_response(stubs={})
    @mock_response ||= mock_model(Response, stubs)
  end

  describe "GET index" do
    it "assigns all responses as @responses" do
      Response.stub(:find).with(:all).and_return([mock_response])
      get :index
      assigns[:responses].should == [mock_response]
    end
  end

  describe "GET show" do
    it "assigns the requested response as @response" do
      Response.stub(:find).with("37").and_return(mock_response)
      get :show, :id => "37"
      assigns[:response].should equal(mock_response)
    end
  end

  describe "GET new" do
    it "assigns a new response as @response" do
      Response.stub(:new).and_return(mock_response)
      get :new
      assigns[:response].should equal(mock_response)
    end
  end

  describe "GET edit" do
    it "assigns the requested response as @response" do
      Response.stub(:find).with("37").and_return(mock_response)
      get :edit, :id => "37"
      assigns[:response].should equal(mock_response)
    end
  end

  describe "POST create" do

    describe "with non-existing permalink" do
      before :each do
        Event.should_receive(:find_by_permalink).with("foo").and_return(nil)
      end

      it "does not attempt to save the response" do
        Response.stub(:new).and_return(mock_response(:event= => nil))
        mock_response.should_not_receive(:save)
        post :create, :permalink => "foo", :response => {}
      end

      it "flashes and redirects" do
        post :create, :permalink => "foo", :response => {}
        flash[:error].should_not be_nil
        response.should redirect_to(create_url)
      end
    end

    describe "with valid params" do
      before do
        @mock_event = mock(Event, :permalink => 'foo')
        Event.should_receive(:find_by_permalink).with("foo").and_return(@mock_event)
      end

      it "assigns a newly created response as @response" do
        Response.stub(:new).with({'these' => 'params'}).and_return(mock_response(
          :save => true, :event= => nil
        ))
        post :create, :permalink => "foo", :response => {:these => 'params'}
        assigns[:response].should equal(mock_response)
      end

      it "resolves the permalink param to an event and associates it with the response" do
        Response.stub(:new).with({'these' => 'params'}).and_return(mock_response(:save => true))
        mock_response.should_receive(:event=).with(@mock_event)
        post :create, :permalink => "foo", :response => {:these => 'params'}
      end

      it "redirects to event page" do
        Response.stub(:new).and_return(mock_response(:save => true, :event= => nil))
        post :create, :permalink => "foo", :response => {}
        response.should redirect_to("/foo")
      end

      it "renders JS template on Ajax request" do
        post :create, :permalink => "foo", :response => @options, :format => 'js'
        response.should render_template("create.js")
      end
    end

    describe "with invalid params" do

      it "assigns a newly created but unsaved response as @response" do
        Response.stub(:new).with({'these' => 'params'}).and_return(mock_response(
          :save => false, :event= => nil
        ))
        post :create, :response => {:these => 'params'}
        assigns[:response].should equal(mock_response)
      end

      it "re-renders the 'new' template" do
        Event.should_receive(:find_by_permalink).with("foo").and_return(
          mock(Event, :permalink => 'foo')
        )
        Response.stub(:new).and_return(mock_response(:save => false, :event= => nil))
        post :create, :permalink => 'foo', :response => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested response" do
        Response.should_receive(:find).with("37").and_return(mock_response)
        mock_response.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :response => {:these => 'params'}
      end

      it "assigns the requested response as @response" do
        Response.stub(:find).and_return(mock_response(:update_attributes => true))
        put :update, :id => "1"
        assigns[:response].should equal(mock_response)
      end

      it "redirects to the response" do
        Response.stub(:find).and_return(mock_response(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(response_url(mock_response))
      end
    end

    describe "with invalid params" do
      it "updates the requested response" do
        Response.should_receive(:find).with("37").and_return(mock_response)
        mock_response.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :response => {:these => 'params'}
      end

      it "assigns the response as @response" do
        Response.stub(:find).and_return(mock_response(:update_attributes => false))
        put :update, :id => "1"
        assigns[:response].should equal(mock_response)
      end

      it "re-renders the 'edit' template" do
        Response.stub(:find).and_return(mock_response(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested response" do
      Response.should_receive(:find).with("37").and_return(mock_response)
      mock_response.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the responses list" do
      Response.stub(:find).and_return(mock_response(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(responses_url)
    end
  end

  it 'routes feeds' do
    { :get => "/feed/my-party" }.should route_to(:controller => 'responses', :action => 'feed', :permalink => 'my-party')
  end

end
