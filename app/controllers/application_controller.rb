class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_musician

  def check_musician 
    #session[:musician_id] =nil
  	if session[:musician_id].nil?
  		@current_musician = nil
  		redirect_to landing_page_path
  	else
  		@current_musician = Musician.find(session[:musician_id])
  	end
  end

end