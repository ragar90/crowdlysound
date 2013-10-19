class CastingSetting < ActiveRecord::Base
  belongs_to :song
  belongs_to :filter_type
end
