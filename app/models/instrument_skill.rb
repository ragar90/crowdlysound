class InstrumentSkill < ActiveRecord::Base
  belongs_to :musician
  belongs_to :instrument
end
