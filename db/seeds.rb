if Instrument.count == 0
	Instrument.create(name: "Guitar")
	Instrument.create(name: "Battery")
	Instrument.create(name: "Bass")
	Instrument.create(name: "Keyboard")
end

if Genre.count == 0
	Genre.create(name: "Rock")
	Genre.create(name: "Pop")
	Genre.create(name: "Reggae")
	Genre.create(name: "Country")
	Genre.create(name: "Jazz")
	Genre.create(name: "R&B")
	Genre.create(name: "Electronic")
	Genre.create(name: "Latin")
	Genre.create(name: "Blues")
	Genre.create(name: "Gospel")
end

if Musician.count == 0
	guest = Musician.new(email: "guest@example.com", name: "Guest User", password: "welcome")
	guest.save

	InstrumentSkill.create(instrument_id: 1, musician_id: 1)
	InstrumentSkill.create(instrument_id: 3, musician_id: 1)

	MusicTaste.create(genre_id: 1, musician_id: 1)
	MusicTaste.create(genre_id: 5, musician_id: 1)
	MusicTaste.create(genre_id: 9, musician_id: 1)

	for i in 1..50
		musician = Musician.new(email: "musician#{i}@example.com", name: "Musician #{i}", password: "welcome")
		musician.save
	end
end

if Band.count == 0
	for i in 1..10
		band = Band.new(name: "Band #{i}")
	end
end