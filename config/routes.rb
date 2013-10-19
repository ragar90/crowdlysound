CrwoudlySound::Application.routes.draw do

  get "landing_page" => "main#landing_page", as: :landing_page
  get "login_as_guest" => "main#login_as_guest", as: :login_as_guest

  root 'main#index'

  resources :songs do
    collection do
      get "castings" => "songs#castings", as: :castings
    end
    member do
      put "casting/:casting_id/status/:satus" => "songs#change_casting_status", as: :casting_status
    end
  end

end