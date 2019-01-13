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

  test 'should store user IP address when creating quote' do
    post quotes_url, params: { quote: { text: 'this is a unique quote guaranteed not to be in any fixtures' } }
    sign_in users(:one)    
    post search_url, params: { pattern: 'this is a unique quote guaranteed not to be in any fixtures' }
    assert_match(/Submitter IP: 127\.0\.0\.1/, response.parsed_body)
  end

  test 'should show quote' do
    get quote_url(@quote)
    assert_response :success
  end

  test 'should show top quotes' do
    get '/top'
    assert_response :success
  end

  test 'should show bottom quotes' do
    get '/bottom'
    assert_response :success
  end

  test 'should show random quotes' do
    get '/random'
    assert_response :success
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
    assert_select "pre", {class: 'quote_output', count: 0}
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

  test 'unauthenticated user should not see submitter IPs for quotes' do
    get quote_url(@quote)
    assert_no_match(/Submitter IP:/, response.parsed_body)
  end

  test 'authenticated user should see submitter IPs for quotes' do
    sign_in users(:one)    
    get quote_url(@quote)
    assert_match(/Submitter IP: 255\.255\.255\.255/, response.parsed_body)
  end

  test 'should offer JSON endpoints' do
    ['/latest.json', '/random.json', '/random1.json', '/bottom.json', '/top.json', "/quotes/#{@quote.id}.json"].each do |endpoint|
      get endpoint
      assert_response :success
      assert JSON.parse(response.body)
    end
  end

end
