class MusicSheet < ActiveRecord::Base
  belongs_to :song
  belongs_to :instrument
  belongs_to :musician
  has_many :comments, as: :comentable
  has_many :rocks, :as => :content
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

  def rocks_by(musician_id, action)
    rock = Rock.find_by_content_id_and_content_type_and_musician_id(self.id, "MusicSheet", musician_id) rescue nil

    if action == 1 && rock.nil?
      Rock.create!(content_id: self.id, content_type: "MusicSheet", musician_id: musician_id)
    elsif action == 0 && !rock.nil?
      rock.destroy
    end
  end

  def rocks_for?(musician_id)
    !Rock.where(:content_id => self.id, :content_type => "MusicSheet", :musician_id => musician_id).empty?
  end
  
end
