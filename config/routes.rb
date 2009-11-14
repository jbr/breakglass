ActionController::Routing::Routes.draw do |map|
  map.resource  :session
  map.resources :families
	map.resource :meeting_places
  map.resource :session
  map.root :controller => 'sessions', :action => 'new'
end
