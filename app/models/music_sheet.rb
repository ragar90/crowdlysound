class MusicSheet < ActiveRecord::Base
  belongs_to :song
  belongs_to :instrument
  belongs_to :musician
  has_many :comments, as: :comentable
end
