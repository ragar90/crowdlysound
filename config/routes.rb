CrwoudlySound::Application.routes.draw do

  get "comments/create"
  get "landing_page" => "main#landing_page", as: :landing_page
  get "login_as_guest" => "main#login_as_guest", as: :login_as_guest

  root 'main#index'

  resources :songs do
    collection do
      get "castings" => "songs#castings", as: :castings
      #get "avaliable_for_castings" => "songs#avaliable_for_castings", as: :castings_avalibles
    end
    member do
      put "casting/:casting_id/approve/for/:instrument_id" => "songs#change_casting_status", as: :aprove_casting, defaults: { status: 1 }
      put "casting/:casting_id/reject/for/:instrument_id" => "songs#change_casting_status", as: :reject_castin, defaults: { status: 2 }    
      post "cover" => "songs#cover", as: :cover
      post "cast" => "song#cast", as: :cast
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

end