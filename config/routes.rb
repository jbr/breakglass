ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resources :families do |family|
    family.resources :people
  end
  map.resources :meeting_places
  map.resource :messages
  map.resource :twilio
  
  map.manifest '/manifest', :controller => 'manifests', :action => 'index'
  map.update_emg_contact_url '/families/update_emg_contact_url', :controller => 'families', :action => 'update_emg_contact'
  map.root :controller => 'families', :action => 'index'
end
