class UsersController < ApplicationController
  before_action :authenticate_user!, except: :change_password
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # POST /admin/users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: "/admin/users/#{@user.id}" }
      else
        format.html { redirect_to "/admin/users/#{@user.id}", notice: "User failed to create: #{@user.errors.keys.first.to_s} #{@user.errors.values.first.to_s}" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /admin/users
  def index
    @users = User.all
    @user = User.new
  end

  # GET /admin/users/id
  def show
    @user = User.find(params[:id])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    unless @user == current_user
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User failed to delete delete: you cannot delete yourself.' }
        format.json { head :no_content }
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end