class Musician < ActiveRecord::Base
  has_many :songs, as: :author
  has_many :cowriters
  has_many :coauthored_songs, through: :cowriters
  has_many :music_tastes
  has_many :genres, through: :music_tastes
  has_many :instrument_skills
  has_many :instruments, through: :instrument_skills
  has_many :agrupations
  has_many :bands, through: :agrupations
  has_many :castings
  has_many :casting_songs, through: :castings

  def create_band(band_params)
    band = Band.new(band_params)
    if !self.new_record? and band.save
      Agrupation.create(band_id: band.id, member_id: self.id, is_leader: true)
    else
      #Error Messages
    end
  end

  def can_edit_music_sheet?(music_sheet)
    cowriter = self.cowriters.where(coauthored_song_id: song.id).first
    return can_edit_song?(music_sheet.song) and cowriter.instrument_id == music_sheet.instrument_id
  end

  def can_edit_song?(song)
    if song.owner_id == self.id and song.owner_type == self.class.to_s
      true
    elsif self.coauthored_song_ids.include?(song.id)
      true
    else
      false
    end
  end




end
