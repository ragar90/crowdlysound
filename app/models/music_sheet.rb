class MusicSheet < ActiveRecord::Base
  belongs_to :song
  belongs_to :instrument
  has_many :coments, as: :comentable
end
