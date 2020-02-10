require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user_example = users(:example)
    @test_user = User.new(name: "Test User", email: "testuser@gmail.com", password: "password", password_confirmation: "password")
    @micropost = @user_example.microposts.build(content: "Lorem ipsum")
  end

  test "micropost should be correct" do
    assert @micropost.valid?
  end

  test "micropost should not be correct" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "micropost's content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "micropost's content length should not be more than 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end

  test "micropost should be delete if user have that micropost get destroyed" do
    @test_user.save
    @test_user.microposts.create!(content: "A test micropost from test user")
    assert_difference 'Micropost.count', -1 do
      @test_user.destroy
    end
  end

  test "should redirect if delete a micropost belong to another user" do
    post login_path, params: {
      session: {
        email: @user_example.email,
        password: 'password',
        remember_me: '1'
      }
    }
    delete_micropost = microposts(:micropost_of_xhieu)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(delete_micropost)
    end
    assert_redirected_to(root_url)
  end
end
