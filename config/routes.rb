ActionController::Routing::Routes.draw do |map|
  map.resource  :session
  map.resources :families
  map.root :controller => 'sessions', :action => 'new'
end
