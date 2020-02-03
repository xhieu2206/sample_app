require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:xhieu)
    # debugger
  end

  test "should show user detail page with microposts and pagination for micropost list" do
    get login_path
    post login_path, params: {
      session: {
        email: @user.email,
        password: "password"
      }
    }
    # assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.pagination'
    @user.microposts.take(10) do |micropost|
      assert_select 'a[href=?]', user_path(user), text: @user.name
      assert_select 'p', text: micropost.content
    end
  end
end
