require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    # @micropost = microposts(:one)
    # debugger
  end

  test "should redirect to login path if create without login" do
    assert_no_difference 'Micropost.count' do
      post microposts_url, params: {
        micropost: "test micropost",
        user_id: @user.id
      }
    end
    assert_redirected_to login_url
  end

  test "should redirect to login path if delete micropost without login" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@user.microposts.first)
    end
    assert_redirected_to login_url
  end
end
