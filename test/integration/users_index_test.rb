require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:xhieu)
    @other_user = users(:example)
  end

  test "users index page with pagination and delete link with name" do
    log_in_as(@admin)
    get users_url
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.first(10).each do |user|
      # Ở đây bắt buộc chúng ta phải sử dụng user_path, vì user_url sẽ là http://www.example.com/users/14035331
      assert_select 'a[href=?]', user_path(user), text: user.name
      assert_select 'a[href=?]', user_path(user), text: "delete" unless user == @admin
    end

    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end

  test "index as non-admin user" do
    log_in_as(@other_user)
    get users_url
    assert_select 'a', text: "delete", count: 0
  end
end
