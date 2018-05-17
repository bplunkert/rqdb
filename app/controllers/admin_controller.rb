class AdminController < ApplicationController
  before_action :authenticate_user!

  # GET /admin
  def index
  	@flagged_quotes = Quote.where(flagged: true)
  	@submitted_quotes = Quote.where(approved: false)
  end

  # GET /admin/flagged
  def flagged
    @quotes = Quote.where(flagged: true).order(created_at: :asc).page(params[:page])
  end

  # GET /admin/submitted
  def submitted
    @quotes = Quote.where(approved: false).order(created_at: :asc).page(params[:page])    
  end

  # GET /admin/users
  def users
    @users = User.all
    @newuser = User.new
  end

  # POST /admin/users
  def create_user
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
