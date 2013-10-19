class MusicSheetsController < ApplicationController
  before_action :set_song
  before_action :set_music_sheet, only: [:show, :edit, :update, :destroy]
  #skip_before_filter :check_musician

  # GET /music_sheets
  # GET /music_sheets.json
  def index
    @music_sheets = @song.music_sheets
  end

  # GET /music_sheets/1
  # GET /music_sheets/1.json
  def show
  end

  # GET /music_sheets/new
  def new
    @music_sheet = MusicSheet.new
    @music_sheet.song_id = @song.id
  end

  # GET /music_sheets/1/edit
  def edit
  end

  # POST /music_sheets
  # POST /music_sheets.json
  def create
    @music_sheet = MusicSheet.new(music_sheet_params)

    respond_to do |format|
      if @music_sheet.save
        format.html { redirect_to @music_sheet, notice: 'Music sheet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @music_sheet }
      else
        format.html { render action: 'new' }
        format.json { render json: @music_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /music_sheets/1
  # PATCH/PUT /music_sheets/1.json
  def update
    respond_to do |format|
      if @music_sheet.update(music_sheet_params)
        format.html { redirect_to @music_sheet, notice: 'Music sheet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @music_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /music_sheets/1
  # DELETE /music_sheets/1.json
  def destroy
    @music_sheet.destroy
    respond_to do |format|
      format.html { redirect_to music_sheets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music_sheet
      @song = Song.where(id: params[:song_id]).first
      @music_sheet = @song.music_sheets.where(id: params[:id]).first
    end

    def set_song
      @song = Song.where(id: params[:song_id]).first
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def music_sheet_params
      params[:music_sheet].permit!
    end
end
