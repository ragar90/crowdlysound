class FollowUser < ActiveRecord::Base

  belongs_to :following, :foreign_key => :user2_id, :class_name => 'Musician'
  belongs_to :follower, :foreign_key => :user1_id, :class_name => 'Musician'

end
