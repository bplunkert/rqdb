class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.where(approved: true).order(created_at: :asc).page(params[:page])
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quotes = [Quote.find(params[:id])]
  end

  # GET /quotes/1/downvote
  # POST /quotes/1/downvote
  def downvote
    @quote = Quote.find(params[:id])
    @quote.update(score: @quote.score - 1)
    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully downvoted.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /quotes/1/upvote
  # POST /quotes/1/upvote
  def upvote
    @quote = Quote.find(params[:id])
    @quote.update(score: @quote.score + 1)
    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully upvoted.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /latest
  # GET /latest.json
  def latest
    @quotes = Quote.where(approved: true).order(created_at: :desc).page(params[:page])
  end

  # GET /top
  # GET /top.json
  def top
    @quotes = Quote.where(approved: true).order(score: :desc).page(params[:page])
  end

  # GET /random
  # GET /random.json
  def random
    @quotes = Quote.where(approved: true).distinct.order("RANDOM()").limit(10)
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

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
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
