CrwoudlySound::Application.routes.draw do

  get "landing_page" => "main#landing_page", as: :landing_page
  get "login_as_guest" => "main#login_as_guest", as: :login_as_guest

  root 'main#index'

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