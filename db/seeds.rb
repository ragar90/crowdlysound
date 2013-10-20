#PLEASE START WITH A CLEAN DATABASE

if FilterType.count == 0
	puts "Adds the Filter Types"
	FilterType.create( name: "instrument")
  	FilterType.create( name: "genre")
  	FilterType.create( name: "both")
  	FilterType.create( name: "none")
end

if Instrument.count == 0
	puts "Adds the instruments"
	Instrument.create!(name: "Guitar")
	Instrument.create!(name: "Drums")
	Instrument.create!(name: "Bass Guitar")
	Instrument.create!(name: "Keyboard")
end

if Genre.count == 0
	puts "Adds the genres"
	Genre.create!(name: "Rock")
	Genre.create!(name: "Pop")
	Genre.create!(name: "Reggae")
	Genre.create!(name: "Country")
	Genre.create!(name: "Jazz")
	Genre.create!(name: "R&B")
	Genre.create!(name: "Electronic")
	Genre.create!(name: "Latin")
	Genre.create!(name: "Blues")
	Genre.create!(name: "Gospel")
end

if Band.count == 0
	puts "Creates empty bands"
	for i in 1..10
		band = Band.new(name: "Band #{i}")
		band.save
	end
end

if Musician.count == 0
	puts "Create musicians with their basic information, creates songs for the musicians and adds the musicians to bands"
	for i in 1..50
		#Basic information of the musician
		musician = Musician.new(email: "musician#{i}@example.com", name: "Musician #{i}", password: "welcome")
		musician.save
		InstrumentSkill.create!(instrument_id: (i%4) + 1, musician_id: musician.id)
		MusicTaste.create!(genre_id: (i%10) + 1, musician_id: musician.id)

		#Adds the first song of the musician
		song = Song.new(owner_id: musician.id, owner_type: "Musician", name: "Song experiment n1 of #{musician.name}", description: "Description of the song experiment n1 of #{musician.name}")
		song.save
		GenreTag.create!(genre_id: (i%10) + 1, song_id: song.id)
		InstrumentTag.create!(instrument_id: (i%4) + 1, song_id: song.id, written_by_me: true)
		MusicSheet.create!(song_id: song.id, instrument_id: (i%4) + 1)
		for j in 1..4
			if j != (i%4) + 1
				InstrumentTag.create!(instrument_id: j, song_id: song.id, written_by_me: false)
				MusicSheet.create!(song_id: song.id, instrument_id: j)
			end
		end

		#Adds the second song of the musician
		song = Song.new(owner_id: musician.id, owner_type: "Musician", name: "Song experiment n2 of #{musician.name}", description: "Description of the song experiment n2 of #{musician.name}")
		song.save
		GenreTag.create!(genre_id: (i%10) + 1, song_id: song.id)
		InstrumentTag.create!(instrument_id: (i%4) + 1, song_id: song.id, written_by_me: true)
		MusicSheet.create!(song_id: song.id, instrument_id: (i%4) + 1)
		for j in 1..4
			if j != (i%4) + 1
				InstrumentTag.create!(instrument_id: j, song_id: song.id, written_by_me: false)
				MusicSheet.create!(song_id: song.id, instrument_id: j)
			end
		end

		#Joins the musician into a band
		Agrupation.create!(member_id: musician.id, band_id: (i%10) + 1, is_leader: i%5 == 0)
	end

	counter = 1
	bands = Band.order("id ASC").limit(10)
	bands.map{ |band|
		#Adds the first song of the band
		song = Song.new(owner_id: band.id, owner_type: "Band", name: "Song n1 of the band #{band.name}", description: "Description of the song n1 of the band #{band.name}")
		song.save
		
		GenreTag.create!(genre_id: counter, song_id: song.id)

		instruments = Instrument.order("id ASC").limit(4)
		instruments.map{ |instrument|
			InstrumentTag.create!(instrument_id: instrument.id, song_id: song.id, written_by_me: true)
			MusicSheet.create!(song_id: song.id, instrument_id: instrument.id)
		}
        
        band.members.map{ |member|
        	Cowriter.create!(coauthor_id: member.id, coauthored_song_id: song.id)
        }

		#Adds the second song of the band
		song = Song.new(owner_id: band.id, owner_type: "Band", name: "Song n2 of the band #{band.name}", description: "Description of the song n2 of the band #{band.name}")
		song.save
		
		GenreTag.create!(genre_id: counter, song_id: song.id)

		instruments = Instrument.order("id ASC").limit(4)
		instruments.map{ |instrument|
			InstrumentTag.create!(instrument_id: instrument.id, song_id: song.id, written_by_me: true)
			MusicSheet.create!(song_id: song.id, instrument_id: instrument.id)
		}
        
        band.members.map{ |member|
        	Cowriter.create!(coauthor_id: member.id, coauthored_song_id: song.id)
        }
	}
end

if FollowUser.count == 0
	puts "Add followers to users"
	musicians = Musician.order("id ASC")
	musicians.map { |musician|
		tmp_musicians = Musician.where("id>? AND id<? AND id<>?", musician.id - 5, musician.id + 5, musician.id)
		tmp_musicians.map{ |tmp_musician|
			musician.follow(tmp_musician)
		}		
	}
end

if FollowBand.count == 0
	puts "Add followers to bands"
	bands = Band.order("id ASC")
	bands.map { |band|
		tmp_musicians = Musician.order("id ASC").limit(14)
		tmp_musicians.map{ |tmp_musician|
			tmp_musician.follow_band(band)
		}		
	}
end