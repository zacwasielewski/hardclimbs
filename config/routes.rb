Hardclimbs::Application.routes.draw do
  resources :climbs do
    resources :ascents
  end
  resources :media_types
  resources :styles
  resources :medias
  resources :ascents do
    resources :medias
  end
  resources :climbers do
    resources :ascents
  end
  
  resources :grades
  resources :areas do
    resources :climbs
    resources :ascents
  end

  match 'search' => 'search#index'
  match 'load_climbers' => 'climbers#load_climber_list'
  match 'load_areas' => 'areas#load_area_list'
  match 'load_climbs' => 'climbs#load_climb_list'
  match 'load_ascents' => 'ascents#load_ascent_list'
  
  authenticated :user do
      root :to => 'home#index'
  end
  root :to => "home#index"
  #devise_for :users
  devise_for :users#, :skip => [:registrations] 
  #as :user do
   # get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
   # put 'users' => 'devise/registrations#update', :as => 'user_registration'
  #end
  resources :users
  
  #high voltage static pages
  get 'about' => 'high_voltage/pages#show', :id => 'about'
  get 'contact' => 'high_voltage/pages#show', :id => 'contact'
  
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  # Any routes that aren't defined above here go to the 404
  match "*aasdfas", :to => "application#routing_error"
  
end
