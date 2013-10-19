CrwoudlySound::Application.routes.draw do

  root 'main#index'

  #Main
  get "landing_page" => "main#landing_page", as: :landing_page
  get "login_as_guest" => "main#login_as_guest", as: :login_as_guest

  #Profile
  get "profile(/:musician_id)" => "profile#profile", as: :profile
  get "edit_profile" => "profile#edit", as: :edit_profile
  put "update_profile" => "profile#update", as: :update_profile
  get "friends/:type" => "profile#friends", as: :friends
  post 'save_instruments' => 'profile#save_instruments'
  post 'save_genres' => 'profile#save_genres'

  #Management of bands
  resources :bands
  get "find_musician/:band_id" => "profile#find_musician"
  post "add_members/:id" => "bands#add_members"
  delete "remove_member_from_band/:id/:member_id" => "bands#remove_member", as: :remove_member_from_band 

end