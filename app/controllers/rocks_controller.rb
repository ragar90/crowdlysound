class RocksController < ApplicationController

	def update
		content_id = params[:content_id]
		content_type = params[:content_type]
		action = params[:action].to_i

		if params[:content_type] == "Song"
			@item = Song.find(params[:content_id])
		elsif params[:content_type] == "MusicSheet"
			@item = MusicSheet.find(params[:content_id])
		end

		@item.rocks_by(@current_musician, action)
	end

end