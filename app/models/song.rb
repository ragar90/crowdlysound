class Song < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  belongs_to :cover_of, class_name: "Song"
  has_many :cowriters
  has_many :coauthors, through: :cowriters
  has_many :music_sheets
  has_many :genre_tags
  has_many :genres, through: :genre_tags
  has_many :comments , as: :comentable
  has_many :castings, foreign_key: :casting_song_id
  has_many :casters, through: :castings
  has_one :casting_setting
  has_many :instrument_tags
  has_many :instruments, through: :instrument_tags
  has_many :rocks, :as => :content
  accepts_nested_attributes_for :instrument_tags

  def clean_written_instrument_dependency
    instrument_ids = self.instrument_tags.group_by{|tag| tag.written_by_me ? :written : :casting}
    written_ids = instrument_ids[:written].map { |tag| tag.id  } rescue []
    casting_ids = instrument_ids[:casting].map { |tag| tag.id  } rescue [] 
    self.castings.update_all({status: 2}, {instrument_id: written_ids})
    self.music_sheets.delete_all
    written_ids.each do |id|
      self.music_sheets << MusicSheet.new(instrument_id: id)
    end
  end

  def cover_for(musician)
    self.transanction do
      begin
        copy = self.dup
        copy.owner_id = musician.id
        copy.owner_type = musician.class.to_s
        copy.cover_of_id = self.id
        if copy.save
          self.instrument_tags.each do |instrument_tag|
            copy.instrument_tags << instrument_tag.dup
          end

          self.genre_tags.each do |genre_tag|
            copy.genre_tags << genre_tag.dup
          end

          self.music_sheets.each do |music_sheet|
            copy.music_sheets << music_sheet.dup
          end
        else
          return false
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  def rocks_by(musician_id, action)
    rock = Rock.find_by_content_id_and_content_type_and_musician_id(self.id, "Song", musician_id) rescue nil

    if action == 1 && rock.nil?
      Rock.create!(content_id: self.id, content_type: "Song", musician_id: musician_id)
    elsif action == 0 && !rock.nil?
      rock.destroy
    end
  end

  def rocks_for?(musician_id)
    !Rock.where(:content_id => self.id, :content_type => "Song", :musician_id => musician_id).empty?
  end
  
end
