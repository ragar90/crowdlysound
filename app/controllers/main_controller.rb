class MainController < ApplicationController

  before_filter :check_musician, except: [:landing_page, :login_as_guest]
  
  def landing_page
  end

  def login_as_guest
  	session[:musician_id] = 1
  	redirect_to root_path
  end

  def index
  end

end