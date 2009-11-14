ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resource :family
  map.root :controller => 'sessions', :action => 'new'
end
