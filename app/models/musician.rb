class Musician < ActiveRecord::Base
  has_many :songs, as: :author
  has_many :cowriters
  has_many :coauthored_songs, through: :cowriters, class_name: :songs
  has_many :music_tastes
  has_many :genres, through: :music_tastes
  has_many :instrument_skills
  has_many :instruments, through: :instrument_skills
  has_many :bands, foreing_key: :leader_id
  has_many :agrupations
  has_many :bands_agrupations, through: :agrupations
end
