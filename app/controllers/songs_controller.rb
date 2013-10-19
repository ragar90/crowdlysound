class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy, :castings, :cover]
  skip_before_filter :check_musician
  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
    Instrument.all.each do |instrument|
      @song.instrument_tags << InstrumentTag.new(instrument_id:instrument.id, written_by_me: false)
    end
    @genres = Genre.all
    @casting_setting = CastingSetting.new
    @filter_types = FilterType.all
  end

  # GET /songs/1/edit
  def edit
    @genres = Genre.all
    @instruments_tags = @song.instrument_tags
    @filter_types = FilterType.all
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)
    #@song.owner_id = current_musician.id
    #@song.owner_type = current_musician.class.to_s
    if casting_setting_params
      casting_setting = CastingSetting.new(casting_setting_params)
      if casting_setting.valid?
        @song.casting_setting = casting_setting
      end
    end

    respond_to do |format|
      if @song.save
        @song.instrument_tags.each do |tag|
          @song.music_sheets << MusicSheet.new(instrument_id: tag.instrument_id) if tag.written_by_me
        end
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render action: 'show', status: :created, location: @song }
      else
        format.html { render action: 'new' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        @song.clean_written_instrument_dependency
        if casting_setting_params
          casting_setting = CastingSetting.new(casting_setting_params)
          if casting_setting.valid?
            @song.casting_setting = casting_setting
            @song.save
          end
        end
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  def castings
    @castings = @song.castings.includes(:caster)
  end

  def cast
    @casting = Casting.new(caster_id: current_musician.id, casting_song_id: @song.id, instrument_id: params[:instrument_id])

    respond_to do |format|
      if @casting.save
        format.html { redirect_to @casting, notice: 'Your Casting was send successfully' }
        format.json { render action: 'show', status: :created, location: @casting }
      else
        format.html { render action: 'new' }
        format.json { render json: @casting.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_casting_status
    @casting = @song.castings.where(id: params[:casting_id]).first
    @casting.status = params[:status].to_i
    @casting.save
    redirect_to root_path
  end

  def cover
    @song.cover_for(current_musician)
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.where(id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params[:song][:genre_ids].delete("") unless params[:song][:genre_ids].nil?
      params[:song].permit!
    end

    def casting_setting_params
      params[:casting_settings].permit! rescue nil
    end
end
