class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.page params[:page]
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quotes = [Quote.find(params[:id])]
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /browse
  # GET /browse.json
  def browse
    @quotes = Quote.where(approved: true)
  end

  # GET /latest
  # GET /latest.json
  def latest
    @quotes = Quote.where(approved: true)
  end

  # GET /random
  # GET /random.json
  def random
    # Generate 25 random IDs
    quote_ids = 25.times.map{ rand(1..Quote.count) }.uniq
    # Select any valid quotes from the above IDs
    @quotes = quote_ids.map{|id| Quote.exists?(id) && Quote.find(id) }.select{|quote| quote unless quote.nil?}
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.score != 0 or @quote.approved
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end

      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:text, :score)
    end
end
