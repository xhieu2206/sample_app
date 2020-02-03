require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:xhieu)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_template 'users/edit'
    patch user_path, params: {
      user: {
        name: 'Xuân Hiếu',
        email: 'xhieu94@gmail',
        password: 'ab',
        password_confirmation: 'bc'
      }
    }
    assert_template 'users/edit'
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_url(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    assert_template 'users/edit'
    name = 'Xuân Hiếu'
    email = 'xhieu94@gmail.com'
    patch user_path, params: {
      user: {
        name: 'Xuân Hiếu New',
        email: 'xhieu94new@gmail.com',
        password: '',
        password_confirmation: ''
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_not_equal name, @user.name
    assert_not_equal email, @user.email
  end
end
