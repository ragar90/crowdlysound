class Cowriter < ActiveRecord::Base
  belongs_to :coauthor, class_name: "Musician", :foreign_key => "coauthor_id"
  belongs_to :coauthored_song, class_name: "Song"
  belongs_to :instrument
end
