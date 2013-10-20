class SearcherController < ApplicationController
  
  def index
  	if !params[:search].nil?
  		@current_musician.make_search(params[:search])
  	end
  end

end
