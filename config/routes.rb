ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.root :controller => 'sessions', :action => 'new'
end
