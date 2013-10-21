class MainController < ApplicationController

  before_filter :check_musician, except: [:landing_page, :login_as_guest, :what_is_crowdly_sound]
  
  def landing_page
  	if !session[:musician_id].nil?
  		redirect_to root_path
  	end
  end

  def login_as_guest
  	if session[:musician_id].nil?
	  	total_musician = Musician.count
	  	guest = Musician.new(email: "guest#{total_musician}@example.com", name: "Guest #{total_musician}", password: "welcome", is_guest: true)
	  	guest.save

	  	Instrument.order("id ASC").limit(2).map{ |instrument|
	  		InstrumentSkill.create!(instrument_id: instrument.id, musician_id: guest.id)
	  	}

	  	Genre.order("id ASC").limit(4).map{ |genre|
	  		MusicTaste.create!(genre_id: genre.id, musician_id: guest.id)
	  	}

  		total_band = Band.count
  		band = Band.new(name: "Band #{total_band}")
  		band.save

		Agrupation.create!(member_id: guest.id, band_id: band.id, is_leader: true)
		Musician.order("id ASC").limit(3).map{ |musician|
			Agrupation.create!(member_id: musician.id, band_id: band.id, is_leader: false)
		}

		#Adds a song to the guest musician
		main_instrument_id = guest.instruments.first.id
		song = Song.new(owner_id: guest.id, owner_type: "Musician", name: "Song of guest #{guest.name}", description: "Description of song of guest #{guest.name}")
		song.save
		GenreTag.create!(genre_id: guest.genres.first.id, song_id: song.id)
		InstrumentTag.create!(instrument_id: main_instrument_id, song_id: song.id, written_by_me: true)
		MusicSheet.create!(song_id: song.id, instrument_id: main_instrument_id)
		
		Instrument.order("id ASC").map{ |instrument|
			if instrument.id != main_instrument_id
				InstrumentTag.create!(instrument_id: instrument.id, song_id: song.id, written_by_me: false)
				MusicSheet.create!(song_id: song.id, instrument_id: instrument.id)
			end
		}

		#Adds the first song of the band
		song = Song.new(owner_id: band.id, owner_type: "Band", name: "Song of the new band #{band.name}", description: "Description of the song of the new band #{band.name}")
		song.save
		
		GenreTag.create!(genre_id: guest.genres.first.id, song_id: song.id)

		instruments = Instrument.order("id ASC").limit(4)
		instruments.map{ |instrument|
			InstrumentTag.create!(instrument_id: instrument.id, song_id: song.id, written_by_me: true)
			MusicSheet.create!(song_id: song.id, instrument_id: instrument.id)
		}
        
        band.members.map{ |member|
        	Cowriter.create!(coauthor_id: member.id, coauthored_song_id: song.id)
        }

        #Loads the musician in the application
	  	session[:musician_id] = guest.id
	end
	
  	redirect_to root_path
  end

  def genres_token_input
    @genres = Genre.where("name like ?", "%#{params[:q]}%").map{|genre| {id: genre.id, name: genre.name}}
    respond_to do |format|
      format.html{}
      format.json{ render json: @genres}
    end
  end

  def index
  end

  def index2
  end

  def what_is_crowdly_sound
  end

end