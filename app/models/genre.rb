class Genre < ActiveRecord::Base
  has_many :music_tastes
  has_many :musicians, through: :music_tastes
  has_many :genre_tags
  has_many :songs, through: :genre_tags
end
