require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active_user = users(:one)
    @other_user = users(:two)

    @user = @active_user
  end

  ['index','show'].each do |method|
    test "unauthenticated user should not #{method} user" do
      get users_url
      assert_redirected_to '/users/sign_in'
    end

    test "authenticated user should #{method} user" do
      sign_in users(:one)
      get users_url
      assert_response :success
    end
  end

  test "unauthenticated user should not create user" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'another@email', password: 'password' } }
    end
    assert_redirected_to '/users/sign_in'
  end

  test "authenticated user should create user" do
    sign_in users(:one)
    assert_difference('User.count', +1) do
      post users_url, params: { user: { email: 'another@email', password: 'password' } }
    end
    assert_redirected_to users_url
  end


  test "unauthenticated user should not destroy user" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'another@email', password: 'password' } }
    end
    assert_redirected_to '/users/sign_in'
  end

  test "authenticated user should not destroy self" do
    sign_in users(:one)
    sign_in users(:one)
    assert_no_difference('User.count') do
      delete "/admin/users/#{@active_user.id}"
    end
    assert_redirected_to users_url

  end

  test "authenticated user should destroy other user" do
    sign_in users(:one)
    assert_difference('User.count', -1) do
      delete "/admin/users/#{@other_user.id}"
    end
    assert_redirected_to users_url
  end

end