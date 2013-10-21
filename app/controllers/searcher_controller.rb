class SearcherController < ApplicationController
  
  def index
  	@results = []
  	if !params[:value].nil?
  		@results = @current_musician.make_search(params[:value])
  	end
  end

end
