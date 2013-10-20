class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy, :add_members, :remove_member]
  before_action :check_band_owner, only: [:edit, :update, :destroy, :add_members, :remove_member]

  # GET /bands
  # GET /bands.json
  def index
    @bands = @current_musician.bands
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
  end

  # GET /bands/new
  def new
    @band = Band.new
  end

  # GET /bands/1/edit
  def edit
  end

  # POST /bands
  # POST /bands.json
  def create
    @band = Band.new(band_params)

    respond_to do |format|
      if @band.save
        #Add current user to band as leader
        Agrupation.create!(band_id: @band.id, member_id: @current_musician.id, is_leader: true)

        format.html { redirect_to @band, notice: 'Band was successfully created.' }
        format.json { render action: 'show', status: :created, location: @band }
      else
        format.html { render action: 'new' }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bands/1
  # PATCH/PUT /bands/1.json
  def update
    respond_to do |format|
      if @band.update(band_params)
        format.html { redirect_to @band, notice: 'Band was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band.destroy
    respond_to do |format|
      format.html { redirect_to bands_url }
      format.json { head :no_content }
    end
  end

  def add_members
    members = params[:members].split(",")

    members.map{ |member|
      @band.add_member(member)
    }
  end

  def remove_member
    @band.remove_member(params[:member_id])
  end

  def follow_band
    action = params[:follow]
    @band = Band.find(params[:band_id].to_i)

    if action == "follow"
      if !@current_musician.currently_follows_band(@band)
        @current_musician.follow_band(@band)
      end
    elsif action == "unfollow"
      if @current_musician.currently_follows_band(@band)
        @current_musician.unfollow_band(@band)
      end
    end
  end

  private
    def set_band
      @band = Band.find(params[:id])
    end

    def check_band_owner
      if !@band.includes_member?(@current_musician.id) || !@current_musician.leader_of(@band.id)
        redirect_to bands_url, :status => :moved_permanently
      end
    end

    def band_params
      params.require(:band).permit(:name, :description)
    end
end
