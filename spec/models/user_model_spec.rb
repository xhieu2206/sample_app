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

  it "should accept valid emails" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |email|
      @user.email = email
      expect(@user.valid?).to eq true
    end
  end

  it "should not accept invalid email" do
    invalid_emails = %w[user@.com USER@foo. @foo.bar.org
      f@foo.jp alice+bob@baz]
  end

  it "email address should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    expect(dup_user.valid?).to eq false
  end

  it "email shhould be saved as lowercase" do
    newMixEmail = "ExamPleEmailTest@gmail.com"
    @user.email = newMixEmail
    @user.save
    expect(newMixEmail.downcase).to eq User.find_by(email: newMixEmail.downcase).email
  end

  it "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user.valid?).to eq false
  end

  it "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user.valid?).to eq false
  end

  it "mock user should be valid" do
    user = double("user")
    another_user = double("user", email: "anotherUser@gmail.com")

    expect(another_user.email).to eq "anotherUser@gmail.com"

    user1 = instance_double(User, name: "Xuân Hiếu")
    # user2 = instance_double(User, name: "Xuân Hiếu", age: 25) # Raise exception vì không có field age
  end
end