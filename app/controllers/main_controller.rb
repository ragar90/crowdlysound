class MainController < ApplicationController

  before_filter :check_musician, except: [:landing_page, :login_as_guest]
  
  def landing_page
  end

  def login_as_guest
  	if session[:musician_id].nil?
	  	total_musician = Musician.count
	  	guest = Musician.new(email: "guest#{total_musician}@example.com", name: "Guest #{total_musician}", password: "welcome", is_guest: true)
	  	guest.save

		InstrumentSkill.create!(instrument_id: 1, musician_id: guest.id)
		InstrumentSkill.create!(instrument_id: 3, musician_id: guest.id)

		MusicTaste.create!(genre_id: 1, musician_id: guest.id)
		MusicTaste.create!(genre_id: 5, musician_id: guest.id)
		MusicTaste.create!(genre_id: 9, musician_id: guest.id)

		total_band = Band.count
		band = Band.new(name: "Band #{total_band}")
		band.save

		Agrupation.create!(member_id: guest.id, band_id: band.id, is_leader: true)
		Agrupation.create!(member_id: 3, band_id: band.id, is_leader: false)
		Agrupation.create!(member_id: 15, band_id: band.id, is_leader: false)
		Agrupation.create!(member_id: 24, band_id: band.id, is_leader: false)

	  	session[:musician_id] = guest.id
	end
	
  	redirect_to root_path
  end

  def index
  end

end