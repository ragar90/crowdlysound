class InstrumentTag < ActiveRecord::Base
  belongs_to :instrument
  belongs_to :song
end
