ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resources :families
  map.resource :meeting_places
  map.resource :messages
  map.resource :twilio, :plural => 'twilio'
  map.root :controller => 'sessions', :action => 'new'
end
