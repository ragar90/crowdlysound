class ProfileController < ApplicationController

	def profile
		if !params[:musician_id].nil?
			@musician = Musician.find(params[:musician_id])
		else
			@musician = @current_musician
		end
	end

	def edit
		@musician = Musician.find(session[:musician_id])
	end

	def update
	end

	def friends
	end

	private
		def user_params
		  params.require(:user).permit(
		    :id,
		    :name,
		    :email,
		    :language_id,
		    :bio
		  )
		end


end
