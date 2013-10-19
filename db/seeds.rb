# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Instrument.all.length == 0
  Instrument.create( name: "Guitar")
  Instrument.create( name: "Bass Guitar")
  Instrument.create( name: "Drums")
end

if Genre.all.length == 0
  Genre.create( name: "Rock")
  Genre.create( name: "Jazz")
  Genre.create( name: "Funk")
  Genre.create( name: "Pop")
  Genre.create( name: "Metal")
end

if FilterType.all.length == 0
  FilterType.create( name: "instrument")
  FilterType.create( name: "genre")
  FilterType.create( name: "both")
  FilterType.create( name: "none")
end