class CastingsController < ApplicationController
  before_action :set_song, except: [:index]
  def index
    @applications = @current_musician.casting_songs.group_by{|casting| casting.casting_song_id}
    @applyable_songs = Song.for_castings.group_by{|song| [song.name.titleize, song.owner.titleize]}
  end

  def apply
    Casting.create(caster_id: @current_musician.id, casting_song_id: @song.id, instrument_id: @instrument.id)
  end

  private

  def set_song
    @song = Song.where(id: params[:song_id]).first
    @instrument = @song.instrument.where(id:params[:instrument_id]).first
  end
end
