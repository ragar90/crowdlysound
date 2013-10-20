CrwoudlySound::Application.routes.draw do

  root 'main#index'

  #Main
  get "landing_page" => "main#landing_page", as: :landing_page
  get "login_as_guest" => "main#login_as_guest", as: :login_as_guest
  get "index2" => "main#index2", as: :index2

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

  #Follows
  get 'follow_user' => 'profile#follow_user'
  get 'user_friends/:id/:kind' => 'profile#user_friends', :as => :user_friends
  get 'follow_band' => 'bands#follow_band'

  resources :songs do
    collection do
      get "castings" => "songs#castings", as: :castings
      #get "avaliable_for_castings" => "songs#avaliable_for_castings", as: :castings_avalibles
    end
    member do
      put "casting/:casting_id/status/:satus" => "songs#change_casting_status", as: :casting_status
      post "cover" => "songs#cover", as: :cover
      post "cast" => "song#cast", as: :cast
    end
    resources :music_sheets
  end

end