class Casting < ActiveRecord::Base
  belongs_to :caster, class_name: "Musician"
  belongs_to :casting_song, class_name: "Song"
  belongs_to :instrument
end
