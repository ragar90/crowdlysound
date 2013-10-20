if FilterType.count == 0
	FilterType.create( name: "instrument")
  	FilterType.create( name: "genre")
  	FilterType.create( name: "both")
  	FilterType.create( name: "none")
end

if Instrument.count == 0
	Instrument.create!(name: "Guitar")
	Instrument.create!(name: "Drums")
	Instrument.create!(name: "Bass")
	Instrument.create!(name: "Keyboard")
end

if Genre.count == 0
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
	for i in 1..11
		band = Band.new(name: "Band #{i}")
		band.save
	end
end

if Musician.count == 0
	guest = Musician.new(email: "guest@example.com", name: "Guest User", password: "welcome")
	guest.save

	InstrumentSkill.create!(instrument_id: 1, musician_id: 1)
	InstrumentSkill.create!(instrument_id: 3, musician_id: 1)

	MusicTaste.create!(genre_id: 1, musician_id: 1)
	MusicTaste.create!(genre_id: 5, musician_id: 1)
	MusicTaste.create!(genre_id: 9, musician_id: 1)

	for i in 1..50
		musician = Musician.new(email: "musician#{i}@example.com", name: "Musician #{i}", password: "welcome")
		musician.save

		band_id = i%10 == 0 ? 10 : i%10
		Agrupation.create!(member_id: musician.id, band_id: band_id, is_leader: i%5 == 0)
	end

	Agrupation.create!(member_id: 1, band_id: 3, is_leader: false)
	Agrupation.create!(member_id: 1, band_id: 11, is_leader: true)
	Agrupation.create!(member_id: 7, band_id: 11, is_leader: false)
	Agrupation.create!(member_id: 17, band_id: 11, is_leader: false)
	Agrupation.create!(member_id: 27, band_id: 11, is_leader: false)
end