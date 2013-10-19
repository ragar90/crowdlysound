class MusicTaste < ActiveRecord::Base
  belongs_to :musician
  belongs_to :genre
end
