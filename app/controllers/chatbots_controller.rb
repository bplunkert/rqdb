class ChatbotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatbot, except: [:index, :create]

  # GET /chatbots
  def index
    @chatbot = Chatbot.new
    @chatbots = Chatbot.all
  end

  # GET /chatbots/1
  # GET /chatbots/1.json
  def show
  end

  # POST /chatbots
  # POST /chatbots.json
  def create
    @chatbot = Chatbot.new(chatbot_params)
    @chatbots = [@chatbot]    

    respond_to do |format|
      if @chatbot.save
        format.html { redirect_to @chatbot, notice: 'chatbot was successfully created.' }
        format.json { render :show, status: :created, location: @chatbot }
      else
        format.html { render :show }
        format.json { render json: @chatbot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatbots/1
  # DELETE /chatbots/1.json
  def destroy
    @chatbot.destroy
    respond_to do |format|
      format.html { redirect_to chatbots_url, notice: 'chatbot was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatbot
      @chatbot = Chatbot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chatbot_params
      params.require(:chatbot).permit(:app, :token)
    end

end