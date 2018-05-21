class SearchController < ApplicationController

  # POST /search
  def index
  	@search = Search.new
    @quotes = Quote.where('text LIKE ?', "%#{params[:pattern]}%").page(params[:page])

    unless params[:pattern].nil? or params[:pattern] == ''
      @quotes = Quote.where('text LIKE ?', "%#{params[:pattern]}%").page(params[:page])
    else
      @quotes = Quote.where(id: nil).page(params[:page])
    end
  end

  def new
  	@search = Search.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:pattern)
    end
end
