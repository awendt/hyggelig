require 'spec_helper'

describe EventsController do
  describe "routing" do
    describe "root" do
      it "works without locale" do
        { :get => "/" }.should route_to(:controller => "events", :action => "new")
      end

      it "works with locale" do
        { :get => "/de" }.should route_to(:controller => "events", :action => "new",
            :locale => 'de')
      end
    end

    it "recognizes locales" do
      { :get => "/en/events" }.should route_to(:controller => "events", :action => "index",
          :locale => 'en')
    end

    it "recognizes and generates #index" do
      { :get => "/events" }.should route_to(:controller => "events", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/events/new" }.should route_to(:controller => "events", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/events/1" }.should route_to(:controller => "events", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/events/1/edit" }.should route_to(:controller => "events", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/events" }.should route_to(:controller => "events", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/events/1" }.should route_to(:controller => "events", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/events/1" }.should route_to(:controller => "events", :action => "destroy", :id => "1")
    end

    it "recognizes and generates feed URLs" do
      { :get => "/feed/my-party" }.should route_to(:controller => "events", :action => "show", :permalink => "my-party", :format => "rss")
    end
  end
end
