class MusicSheet < ActiveRecord::Base
  belongs_to :song
  belongs_to :instrument
  has_many :comments, as: :comentable
end
