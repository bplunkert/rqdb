require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search = searches(:one)
  end

  test "search should return matching quotes" do
    post '/search', params: { search: { search_pattern: 'MyString1' } }
    assert_response :success

  assert_select "a", {:count=>1, :text=>"#1"}, "Did not find matching quote in search results"

  end
end