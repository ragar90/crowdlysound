CrwoudlySound::Application.routes.draw do

  get "landing_page" => "main#landing_page", as: :landing_page
  get "login_as_guest" => "main#login_as_guest", as: :login_as_guest

  root 'main#index'

end