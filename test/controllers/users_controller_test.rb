require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:xhieu)
    @other_user = users(:example)
    @other_user_2 = users(:michael)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)

    test "users index page "
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_url(@user), params: {
      user: {
        email: @user.email,
        name: @user.name
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when not logged in" do
    get users_url
    assert_redirected_to login_path
  end

  test "should redirect when delete without login" do
    assert_no_difference 'User.count' do
      delete user_path(@other_user)
    end
    assert_redirected_to(login_url)
  end

  test "should redirect when delete without admin permission" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@other_user_2)
    end
    assert_redirected_to(root_url)
  end

end
