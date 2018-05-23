require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quotes = quotes
    @quote = quotes(:one)
    @flagged_quote = quotes(:two)
  end

  test 'should get index' do
    get quotes_url
    assert_response :success
  end

  test 'should get new' do
    get new_quote_url
    assert_response :success
  end

  test 'should create quote' do
    assert_difference('Quote.count', +1) do
      post quotes_url, params: { quote: { text: @quote.text } }
    end
  end

  test 'should show quote' do
    get quote_url(@quote)
    assert_response :success
  end

  test 'should upvote quote' do
    assert_difference('@quote.score', +1) do
      get "/quotes/#{@quote.id}/upvote"
    end
    assert_redirected_to quote_url(@quote)
  end

  test 'should downvote quote' do
    assert_difference('Quote.find(@quote.id).score', -1) do
      get "/quotes/#{@quote.id}/downvote"
    end
    assert_redirected_to quote_url(@quote)
  end  

  test 'authenticated user should destroy quote' do
    sign_in users(:one)
    assert_difference('Quote.count', -1) do
      delete quote_url(@quote)
    end
  end

  test 'unauthenticated user should not destroy quote' do
    assert_no_difference('Quote.count') do
      delete quote_url(@quote)
    end
    assert_redirected_to '/users/sign_in'
  end

  test 'unauthenticated user should not unflag quote' do
    assert_no_changes('Quote.find(@flagged_quote.id).flagged') do
      get "/quotes/#{@flagged_quote.id}/unflag"
    end
    assert_redirected_to '/users/sign_in'
  end
  
  test 'authenticated user should unflag quote' do
    sign_in users(:one)
    assert_changes('Quote.find(@flagged_quote.id).flagged') do
      get "/quotes/#{@flagged_quote.id}/unflag"
    end
  end

  test 'random should return empty page when there are no quotes' do
    sign_in users(:one)
    @quotes.each do |quote|
      delete quote_url(quote)
    end

    get '/random'
    assert_select "pre", {:class => "quote_output", :count=>0}
    assert_response :success
  end

  test 'unauthenticated user should not update quote' do
    assert_no_changes('Quote.find(@quote.id).text') do
      patch quote_url(@quote), params: { quote: {id: 1, text: 'Modified text'} }
    end
    assert_redirected_to '/users/sign_in'
  end

  test 'authenticated user should update quote' do
    sign_in users(:one)
    assert_changes('Quote.find(@quote.id).text') do
      patch quote_url(@quote), params: { quote: {id: 1,  text: 'Modified text'} }
    end
    assert_redirected_to quote_url(@quote)
  end

end
