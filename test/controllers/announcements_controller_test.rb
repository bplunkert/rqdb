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
    assert_match /My first announcement/, response.parsed_body, 'Failed to find first announcement'
    assert_match /My other announcement/, response.parsed_body, 'Failed to find other announcement'
  end

  test 'unauthenticated user should not create announcement' do
    assert_no_difference('Announcement.count') do
      post announcements_url, params: { announcement: { text: 'My new announcement' } }
    end
    assert_redirected_to '/users/sign_in'
  end

  test 'authenticated user should create announcement' do
    sign_in users(:one)
    assert_difference('Announcement.count', +1) do
      post announcements_url, params: { announcement: { text: 'My new announcement' } }
    end
  end

  test 'authenticated user should not create blank announcement' do
    sign_in users(:one)
    assert_no_difference('Announcement.count') do
      post announcements_url, params: { announcement: { text: '' } }
    end
  end

  test 'unauthenticated user should not destroy announcement' do
    assert_no_difference('Announcement.count') do
      delete announcement_url(@announcement)
    end
    assert_redirected_to '/users/sign_in'
  end

  test 'authenticated user should destroy announcement' do
    sign_in users(:one)
    assert_difference('Announcement.count', -1) do
      delete announcement_url(@announcement)
    end
  end

  test 'unauthenticated user should not update announcement' do
    assert_no_changes('Announcement.find(@announcement.id).text') do
      patch announcement_url(@announcement), params: { announcement: {id: 1, text: 'Modified text'} }
    end
    assert_redirected_to '/users/sign_in'
  end

  test 'authenticated user should update announcement' do
    sign_in users(:one)    
    assert_changes('Announcement.find(@announcement.id).text') do
      patch announcement_url(@announcement), params: { announcement: {id: 1,  text: 'Modified text'} }
    end
    assert_redirected_to announcements_url
  end
end