CrwoudlySound::Application.routes.draw do

  root 'main#index'

  #Main
  get "landing_page" => "main#landing_page", as: :landing_page
  get "login_as_guest" => "main#login_as_guest", as: :login_as_guest

  #Profile
  get "profile(/:id)" => "profile#profile", as: :profile
  get "edit_profile" => "profile#edit", as: :edit_profile
  put "update_profile" => "profile#update", as: :update_profile
  get "friends/:type" => "profile#friends", as: :friends

end