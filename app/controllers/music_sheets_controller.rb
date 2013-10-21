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
    @comments = @music_sheet.comments
    @coomentable = @music_sheet
  end

  # GET /music_sheets/1/edit
  def edit
  end

  # PATCH/PUT /music_sheets/1
  # PATCH/PUT /music_sheets/1.json
  def update
    respond_to do |format|
      if @music_sheet.update(music_sheet_params)
        format.html { redirect_to song_path(id: @song.id), notice: 'Music sheet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @music_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  def rock
    @music_sheet.rock_likes_count+=1
    @music_sheet.save
    respond_to do |format|
      format.html { redirect_to root_path, notice: "This Song rocks you \\m/" }
      format.json { render json: {message: "This Song rocks you \\m/"}, status: :created, location: @music_sheet }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music_sheet
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
