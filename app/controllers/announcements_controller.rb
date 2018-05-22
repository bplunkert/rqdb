class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  # GET /announcements
  # GET /announcements
  def index
    @announcements = Announcement.order(created_at: :asc).page(params[:page])
  end

  # GET /announcement/1
  # GET /announcement/1.json
  def show
    @announcements = [Announcement.find(params[:id])]
  end

  # POST /announcements
  # POST /announcements.json
  def create
    authenticate_user!
    @announcement = Announcement.new(announcement_params)
    respond_to do |format|
      if @announcement.save
        format.html { redirect_to announcements_url, notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: announcements_url }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    authenticate_user!
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to announcements_url, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: announcements_url }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    authenticate_user!
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:text)
    end
end
