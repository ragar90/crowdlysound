class Casting < ActiveRecord::Base
  belongs_to :caster, class_name: "Musician"
  belongs_to :casting_song, class_name: "Song"
  belongs_to :instrument
  before_create :pre_casting

  def pre_casting
    filter_type = self.casting_song.casting_setting.filter_type.name.to_sym
    case filter_type
    when :instrument
      self.status = can_apply_through_instruments? ? 3 : 2
    when :genre
      self.status = can_apply_through_genres? ? 3 : 2
    when :both
      self.status = (can_apply_through_genres? and can_apply_through_instruments?) ? 3 : 2
    else
      self.status = 3
    end
  end

  def can_apply_through_instruments?
    require_instruments_ids = self.casting_song.instrument_tags.where(:written_by_me, false).map{|tag| tag.instrument_id}
    available_instruments_ids = self.caster.instrument_ids
    (require_instruments_ids - available_instruments_ids).length > 0
  end

  def can_apply_through_genres?
    require_genres_ids = self.casting_song.instrument_tags.map{|tag| tag.genre_id}
    available_genres_ids = self.caster.music_taste_ids
    (require_instruments_ids - available_instruments_ids).length > 0
  end
end
