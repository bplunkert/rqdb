class AdminController < ApplicationController
  before_action :authenticate_user!

  # GET /admin
  def index
  	@flagged_quotes = Quote.where(flagged: true)
  	@submitted_quotes = Quote.where(approved: false)

  	# if user_signed_in? 
  	# show admin navigation in main section
  	# links to:
  	# submitted quote review
  	# flagged quote review
  	# user management
  	#
  	# otherwise send to login page
  end

  # GET /admin/flagged
  def flagged
    @quotes = Quote.where(flagged: true).order(created_at: :asc).page(params[:page])
  end

  # GET /admin/submitted
  def submitted
    @quotes = Quote.where(approved: false).order(created_at: :asc).page(params[:page])    
  end

end
