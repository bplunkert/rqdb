require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote = quotes(:one)
  end

  test 'user should upvote quote only once' do
    assert_difference('Quote.find(@quote.id).score', +1) do
      3.times do
        get "/quotes/#{@quote.id}/upvote"
      end
    end
    assert_redirected_to quote_url(@quote)
  end

  test 'user should downvote quote only once' do
    assert_difference('Quote.find(@quote.id).score', -1) do
      3.times do
        get "/quotes/#{@quote.id}/downvote"
      end
    end
    assert_redirected_to quote_url(@quote)
  end
end
