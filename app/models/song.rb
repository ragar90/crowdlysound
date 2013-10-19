class Song < ActiveRecord::Base
  belongs_to :author,polymorphic: true
  has_many :cowriters
  has_many :coauthors, through: :cowriters
  has_many :music_sheets
  has_many :genre_tags
  has_many :genres, through: :genre_tags
  has_many :comments , as: :comentable
  has_many :castings
  has_many :casters, through: :castings
  has_one :casting_setting
  has_many :intrument_tags
  has_many :instrument, through: :intrument_tags
end
