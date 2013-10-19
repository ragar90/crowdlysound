class ProfileController < ApplicationController

	def profile
		if !params[:musician_id].nil?
			@musician = Musician.find(params[:musician_id])
		else
			@musician = @current_musician
		end

		@all_instruments = Instrument.order("name ASC")
		@musician_instruments = @musician.instruments

		@all_genres = Genre.order("name ASC")
		@musician_genres = @musician.genres
	end

	def edit
		@musician = Musician.find(session[:musician_id])
	end

	def update
	end

	def save_instruments
	    @current_musician.instrument_skills.destroy_all

	    params[:instruments].map{ |instrument_id| 
	      InstrumentSkill.create!(musician_id: @current_musician.id, instrument_id: instrument_id)
	    }

	    render :nothing => true
	end

	def save_genres
	    @current_musician.music_tastes.destroy_all

	    params[:genres].map{ |genre_id| 
	      MusicTaste.create!(musician_id: @current_musician.id, genre_id: genre_id)
	    }

	    render :nothing => true
	end

	def follow_user
		action = params[:follow]
		@musician = Musician.find(params[:musician_id].to_i)
		@error = false

		if @current_musician.id != @musician.id
		  if action == "follow"
		    if !@current_musician.follows_user(@musician)
		      @current_musician.follow(@musician)
		    end
		  elsif action == "unfollow"
		    if @current_musician.follows_user(@musician)
		      @current_musician.unfollow(@musician)
		    end
		  end
		else
		  @error = true
		end
	end

	def friends
	end

	def find_musician    
		@musicians = Musician.find_musician(params[:term], params[:band_id])
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
