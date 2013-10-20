class Instrument < ActiveRecord::Base
  has_many :instrument_skills
  has_many :musicians, through: :instrument_skills
  has_many :music_sheets
  has_many :intrument_tags
  has_many :songs, through: :intrument_tags
  has_many :cowriters
end
