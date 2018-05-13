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
    all_quotes = Quote.where(approved: true)
    max_id     = all_quotes.last(1).first.id
    quote_ids  = []
    while (quote_ids.count < 10) and (quote_ids.count < all_quotes.count)
      i = rand(1..max_id)
      if Quote.exists?(id: i) and Quote.approved == true
        unless quote_ids.include?(i)
          quote_ids << i 
        end
      end
    end

    @quotes = quote_ids.map{|id| Quote.find(id) if Quote.exists?(id: id)}
  end

  # GET /random1
  # GET /random1.json
  def random1
    all_quotes = Quote.where(approved: true)
    max_id     = all_quotes.last(1).first.id
    quote_ids  = []
    while (quote_ids.count < 10) and (quote_ids.count < all_quotes.count)
      i = rand(1..max_id)
      if Quote.exists?(id: i) and Quote.approved == true and Quote.score > 0
        unless quote_ids.include?(i)
          quote_ids << i 
        end  
      end
    end

    @quotes = quote_ids.map{|id| Quote.find(id) if Quote.exists?(id: id)}
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
