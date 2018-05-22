class AnnouncementsController < ApplicationController
  # GET /quotes
  # GET /quotes.json
  def index
    @announcements = Announcement.order(created_at: :asc).page(params[:page])
  end

end
