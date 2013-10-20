class SongsController < ApplicationController
  before_action :set_song, except: [:new, :index ]
  #skip_before_filter :check_musician
  # GET /songs
  # GET /songs.json
  def index
    @songs = @current_musician.songs
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @comments = @song.comments
    @coomentable = @song
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
    @band_id = 0
  end

  def new_band_song
    @band = Band.find(params[:band_id])

    if @current_musician.belongs_to_band?(@band.id)
      @song = Song.new
      Instrument.all.each do |instrument|
        @song.instrument_tags << InstrumentTag.new(instrument_id:instrument.id, written_by_me: false)
      end
      @genres = Genre.all
      @casting_setting = CastingSetting.new
      @filter_types = FilterType.all

      @band_id = @band.id

      render "new"
    else
      redirect_to bands_path
      return
    end
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

    if params[:band_id].to_i == 0
      @song.owner_id = @current_musician.id
      @song.owner_type = @current_musician.class.to_s
    else
      @band = Band.find(params[:band_id]) rescue nil
      if !@band.nil? && @current_musician.belongs_to_band?(@band.id)
        @song.owner_id = @band.id
        @song.owner_type = @band.class.to_s
      else
        redirect_to bands_path
        return
      end
    end

    if casting_setting_params
      casting_setting = CastingSetting.new(casting_setting_params)
      if casting_setting.valid?
        @song.casting_setting = casting_setting
      end
    end

    respond_to do |format|
      if @song.save
        if @song.owner_type == "Band"
          @band.members.map{ |member|
            Cowriter.create!(coauthor_id: member.id, coauthored_song_id: @song.id)
          }
        end

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
        format.html { redirect_to root_path, notice: 'Your Casting was send successfully' }
        format.json { render action: 'show', status: :created, location: @casting }
      else
        format.html { redirect_to root_path, notice: 'Somthing went wrong with your application' }
      end
    end
  end

  def change_casting_status
    @casting = @song.castings.where(id: params[:casting_id]).first
    @casting.status = params[:status].to_i
    @casting.save
    if @casting.status == 1
      @song.cowriters << Cowriter.new(instrument_id: params[:instrument_id], coauthor_id: @casting.caster_id)
    end
    redirect_to root_path
  end

  def cover
    @song.cover_for(current_musician)
    redirect_to root_path
  end

  def remove_cowriter
    @song.cowriters.where(coauthor_id: params[:coauthor_id], instrument_id: params[:instrument_id]).first.destroy
    redirect_to root_path
  end

  def rock
    @song.rock_likes_count+=1
    @song.save
    respond_to do |format|
      format.html { redirect_to root_path, notice: "This Song rocks you \\m/" }
      format.json { render json: {message: "This Song rocks you \\m/"}, status: :created, location: @song }
    end
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
