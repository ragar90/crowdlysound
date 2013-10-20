class MusicSheet < ActiveRecord::Base
  belongs_to :song
  belongs_to :instrument
  belongs_to :musician
  has_many :comments, as: :comentable
  before_create :set_default_notes

  def set_default_notes
    clef = "clef=treble"
    if notes.blank?
      case self.instrument_id
        when 1
          clef = "clef=treble"
        when 2
          clef = "clef=percussion"
        when 3
          clef = "clef=bass"
        when 4
          clef = "clef=treble"
      end
    end
    self.notes = "tabstave notation=true #{clef}" 
  end
end
