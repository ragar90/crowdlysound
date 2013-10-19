class ProfileController < ApplicationController

	before_action :check_current_user, except: [:profile]

	def profile
		@current_user = false

		if params[:musician_id].nil?
			@musician = Musician.find(session[:musician_id])
		else
			@current_user = true
			@musician = Musician.fnd(params[:musician_id])
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
