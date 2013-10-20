class Cowriter < ActiveRecord::Base
  belongs_to :coauthor, class_name: "Musician"
  belongs_to :coauthored_song, class_name: "Song"
  belongs_to :instrument
end
