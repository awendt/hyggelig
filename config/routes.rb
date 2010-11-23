# ActionController::Routing::Routes.draw do |map|
#   map.filter 'locale'
# 
#   map.resources :events
#   map.resources :replies
# 
#   map.root :controller => 'events', :action => 'new'
#   map.static '/:action', :controller => 'static_pages', :action => StaticPagesController::PAGES
#   map.feed '/feed/:permalink', :controller => 'events', :action => 'show', :format => 'rss'
#   map.permalink '/:permalink', :controller => 'events', :action => 'show'
#   map.reply '/reply/:permalink', :controller => 'replies', :action => 'create'
# 
#   map.connect ':controller/:action/:id'
#   map.connect ':controller/:action/:id.:format'
# end


HyggeligOrg::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  resources :events
  resources :replies

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "events#new"

  #   map.feed '/feed/:permalink', :controller => 'events', :action => 'show', :format => 'rss'
  #   map.permalink '/:permalink', :controller => 'events', :action => 'show'
  #   map.reply '/reply/:permalink', :controller => 'replies', :action => 'create'
  match 'feed/:permalink' => 'events#show', :as => :feed, :defaults => { :format => 'rss' }
  match ':permalink' => 'events#show', :as => :permalink
  match 'reply/:permalink' => 'replies#create', :as => :reply

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
