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
  scope "(:locale)", :locale => %r(#{I18n.available_locales.join('|')}) do
    resources :events
    resources :replies

    root :to => "events#new"

    #   map.static '/:action', :controller => 'static_pages', :action => StaticPagesController::PAGES
    #   map.feed '/feed/:permalink', :controller => 'events', :action => 'show', :format => 'rss'
    #   map.permalink '/:permalink', :controller => 'events', :action => 'show'
    #   map.reply '/reply/:permalink', :controller => 'replies', :action => 'create'
    match '/:action' => 'static_pages', :as => :static,
        :constraints => {:action => StaticPagesController::PAGES}
    match 'feed/:permalink' => 'events#show', :as => :feed, :defaults => { :format => 'rss' }
    match ':permalink' => 'events#show', :as => :permalink
    match 'reply/:permalink' => 'replies#create', :as => :reply

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    match ':controller(/:action(/:id(.:format)))'
  end

end
