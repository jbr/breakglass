ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resources :families do |family|
    family.resources :people
  end
  map.resource :meeting_places
  map.resource :messages
  map.resource :twilio
  
  map.manifest '/manifest', :controller => 'manifests', :action => 'index'
  map.root :controller => 'families', :action => 'index'
end
