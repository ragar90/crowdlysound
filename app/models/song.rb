class Song < ActiveRecord::Base
  belongs_to :author,polymorphic: true
  has_many :cowriters
  has_many :coauthors, through: :cowriters
  has_many :music_sheets
  has_many :genre_tags
  has_many :genres, through: :genre_tags
  has_many :comments , as: :comentable
end
