class Instrument < ActiveRecord::Base
  has_many :music_skills
  has_many :musicians, through: :music_skills
end
