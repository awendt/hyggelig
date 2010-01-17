require 'spec_helper'

describe ResponsesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/responses" }.should route_to(:controller => "responses", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/responses/new" }.should route_to(:controller => "responses", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/responses/1" }.should route_to(:controller => "responses", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/responses/1/edit" }.should route_to(:controller => "responses", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/responses" }.should route_to(:controller => "responses", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/responses/1" }.should route_to(:controller => "responses", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/responses/1" }.should route_to(:controller => "responses", :action => "destroy", :id => "1") 
    end
  end
end
