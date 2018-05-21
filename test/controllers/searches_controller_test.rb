require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search = searches(:one)
  end

  test "search should return matching quotes" do
    post '/search', params: { search: { search_pattern: 'MyString1' } }
    assert_response :success
    assert_select "pre", {:class => "quote_output", :count=>1}

  end

  test "search should not return nonmatching quotes" do
    post '/search', params: { search: { search_pattern: 'BogusStringWithNoMatchingQuotes' } }
    assert_response :success
    assert_select "pre", {:class => "quote_output", :count=>0}
  end

  test "empty search pattern should not return quotes" do
    post '/search', params: { search: { search_pattern: '' } }
    assert_response :success
    assert_select "pre", {:class => "quote_output", :count=>0}
  end
end