require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote = quotes(:one)
    @flagged_quote = quotes(:two)
  end

  test "should get index" do
    get quotes_url
    assert_response :success
  end

  test "should get new" do
    get new_quote_url
    assert_response :success
  end

  test "should create quote" do
    assert_difference('Quote.count') do
      post quotes_url, params: { quote: { score: @quote.score, text: @quote.text } }
    end
  end

  test "should show quote" do
    get quote_url(@quote)
    assert_response :success
  end

  test "search should return matching quotes" do
    results = Quote.search('MyString1')
    assert results.count == 1
  end

  test "should update quote" do
    patch quote_url(@quote), params: { quote: { score: @quote.score, text: @quote.text } }
    assert_redirected_to quote_url(@quote)
  end

  test "authenticated user should destroy quote" do
    sign_in users(:one)
    assert_difference('Quote.count', -1) do
      delete quote_url(@quote)
    end
  end

  test "unauthenticated user should not destroy quote" do
    assert_no_difference('Quote.count') do
      delete quote_url(@quote)
    end
    assert_redirected_to '/users/sign_in'    
  end

  test "unauthenticated user should not unflag quote" do
    assert_no_changes('Quote.find(@flagged_quote.id).flagged') do
      get "/quotes/#{@flagged_quote.id}/unflag"
    end
    assert_redirected_to '/users/sign_in'
  end
  
  test "authenticated user should unflag quote" do
    sign_in users(:one)
    assert_changes('Quote.find(@flagged_quote.id).flagged') do
      get "/quotes/#{@flagged_quote.id}/unflag"
    end
  end

end
