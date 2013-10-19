class Genre < ActiveRecord::Base
  has_many :music_tastes
  has_many :musicians, through: :music_tastes
end
