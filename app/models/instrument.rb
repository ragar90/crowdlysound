class Instrument < ActiveRecord::Base
  has_many :instrument_skills
  has_many :musicians, through: :instrument_skills
  has_many :music_sheets
end
