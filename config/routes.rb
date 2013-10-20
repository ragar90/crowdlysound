CrwoudlySound::Application.routes.draw do
  root 'main#index'

  get "what_is_crowdly_sound" => "main#what_is_crowdly_sound", as: :what_is_crowdly_sound
  get "landing_page" => "main#landing_page", as: :landing_page
  get "login_as_guest" => "main#login_as_guest", as: :login_as_guest
  get "index2" => "main#index2", as: :index2

  get "search" => "searcher#index", as: :search

  scope :castings do
    get "" => "castings#index", as: :castings
    post "apply/:song_id/for/:instrument_id" => "castings#apply", as: :apply_casting
  end

  get "genres" => "main#genres_token_input", as: :genres_token_input

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
  get "new_band_song/:band_id" => "songs#new_band_song", as: :new_band_song

  #Follows
  get 'follow_user' => 'profile#follow_user'
  get 'user_friends/:id/:kind' => 'profile#user_friends', :as => :user_friends
  get 'follow_band' => 'bands#follow_band'

  resources :songs do
    member do
      get "castings"
      put "casting/:casting_id/approve/for/:instrument_id" => "songs#change_casting_status", as: :aprove_casting, defaults: { status: 1 }
      put "casting/:casting_id/reject/for/:instrument_id" => "songs#change_casting_status", as: :reject_castin, defaults: { status: 2 }    
      post "cover" => "songs#cover", as: :cover
      post "cast" => "songs#cast", as: :cast
      delete "remove_cowriter/:coauthor_id/for/:instrument_id" => "songs#remove_cowriter", as: :remove_cowriter
      put "rock" => "songs#rock", as: :rock
    end

    resources :music_sheets, only: [:index, :edit, :update, :show] do
      member do
        put "rock" => "music_sheets#rock", as: :rock
      end
    end
  end
  post "comment" => "comments#create"
  get "rock/:content_id/:content_type/:action_value" => "rocks#update", :as => "rock"

end