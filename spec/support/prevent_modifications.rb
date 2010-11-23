def it_should_prevent_modifications
  {'index' => :get, 'edit' => :get, 'update' => :put, 'destroy' => :delete}.each_pair do |action, verb|
    it "#{action} should redirect to EventsController#create with error" do
      send(verb, action)
      response.should redirect_to(root_path)
    end
  end
end