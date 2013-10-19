class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy, :castings]
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
    @instruments = Instrument.all
    @genres = Genre.all
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    redirect_to songs_path, notice: 'Song was successfully created.'
    #@song = Song.new(song_params)
    #casting_setting = CastingSetting.new(casting_setting_params)
    #if casting_setting.valid?
    #  @song.casting_setting = casting_setting
    #end
    #respond_to do |format|
    #  if @song.save
    #    params[:instrument_tags].each do |tag_params|
    #      @song.instrument_tags << InstrumentTag.new(instrument_id: tag_params[:instrument_id], is_written_by_me: tag_params[:is_written_by_me])
    #    end
    #    format.html { redirect_to @song, notice: 'Song was successfully created.' }
    #    format.json { render action: 'show', status: :created, location: @song }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @song.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
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

  def change_casting_status
    @casting = @song.castings.where(id: params[:casting_id]).first
    @casting.status = params[:status].to_i
    @casting.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.where(params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params[:song].permit!
    end

    def casting_setting_params
      params[:casting_setting].permit!
    end
end
