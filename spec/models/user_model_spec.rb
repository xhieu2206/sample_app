require "rails_helper"

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = "defined"
end

RSpec.describe User, :type => :model do
  fixtures :users

  before(:example) do
    @user = User.new(name: "Example User Test", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  it "should have atleast 36 user" do
    expect(User.count).to eq 36
  end

  it "should be valid" do
    expect(@user.valid?).to eq true
  end

  it "should not be valid because of empty string in name" do
    @user.name = ""
    expect(@user.valid?).to eq false
  end

  it "should be valid because of @user instance have been rollback to before example after previous example" do
    expect(@user.valid?).to eq true
  end

  it "should not be valid because name is too long" do
    @user.name = "a" * 60
    expect(@user.valid?).to eq false
  end

  it "should not be valid because email is too long" do
    @user.email = "a" * 200 + "@email.com"
    expect(@user.valid?).to eq false
  end

  it "should accept "
end