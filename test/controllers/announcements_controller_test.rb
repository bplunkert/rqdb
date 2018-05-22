require 'test_helper'

class AnnouncementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @announcements = announcements
    @announcement  = announcements(:one)
  end

  test 'should get index' do
    get '/'
    assert_response :success
  end
end