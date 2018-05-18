class UsersController < ApplicationController
  before_action :authenticate_user!, except: :change_password
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  	@users = User.all
  	@newuser = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/users', notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to '/users' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @quote = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end