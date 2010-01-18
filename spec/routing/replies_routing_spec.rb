require 'spec_helper'

describe RepliesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/replies" }.should route_to(:controller => "replies", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/replies/new" }.should route_to(:controller => "replies", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/replies/1" }.should route_to(:controller => "replies", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/replies/1/edit" }.should route_to(:controller => "replies", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/replies" }.should route_to(:controller => "replies", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/replies/1" }.should route_to(:controller => "replies", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/replies/1" }.should route_to(:controller => "replies", :action => "destroy", :id => "1")
    end
  end
end
