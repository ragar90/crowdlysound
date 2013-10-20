class RocksController < ApplicationController

	def update
		content_id = params[:content_id]
		content_type = params[:content_type]
		action = params[:action_value].to_i

		if params[:content_type] == "Song"
			@item = Song.find(params[:content_id])
		elsif params[:content_type] == "MusicSheet"
			@item = MusicSheet.find(params[:content_id])
		end

		logger.debug "CM: #{@current_musician.inspect}"
		@item.rocks_by(@current_musician.id, action)
	end

end