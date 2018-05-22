require 'test_helper'

class AnnouncementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @announcements = announcements
    @announcement  = announcements(:one)
  end

  test 'should get index' do
    get '/'
    assert_response :success
    assert_select 'div.announcements', {:count=>1}
    assert_select 'div.announcement', {:count=>2}
  end

  test 'unauthenticated user should not add announcement' do
    assert_no_changes('Announcement.count') do
      false
    end
    assert_redirected_to '/users/sign_in'
  end

  test 'authenticated user should add announcement' do
    sign_in users(:one)
    assert_no_changes('Announcement.count') do
      false
    end
  end
end