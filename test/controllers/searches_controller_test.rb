require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search = searches(:one)
  end

  test 'search should return matching quotes' do
    post search_url, params: { pattern: 'MyString2' }
    assert_response :success
    assert_select 'pre', {:class => 'quote_output', :count=>1}    
    assert_match /MyString2/, response.parsed_body, 'Search failed when passing valid quote_id parameter'
  end

  test 'search should not return nonmatching quotes' do
    post search_url, params: { pattern: 'BogusStringWithNoMatchingQuotes' }
    assert_response :success
    assert_select 'pre', {:class => 'quote_output', :count=>0}
  end

  test 'empty search pattern should not return quotes' do
    post search_url, params: { pattern: '' }
    assert_response :success
    assert_select 'pre', {:class => 'quote_output', :count=>0}
  end

  test 'search with valid quote_id should return only one quote' do
    post search_url, params: { quote_id: 2 }
    assert_response :success
    assert_select 'pre', {:class => 'quote_output', :count=>1}
  end

  test 'search with invalid quote_id should return no quotes' do
    post search_url, params: { quote_id: 999999999999 }
    assert_response :success
    assert_select 'pre', {:class => 'quote_output', :count=>0}
  end
end