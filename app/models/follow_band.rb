class FollowBand < ActiveRecord::Base
  belongs_to :following_band, :class_name => "Band", :foreign_key => "band_id"
  belongs_to :follower, :class_name => "Musician", :foreign_key => "musician_id"
end
