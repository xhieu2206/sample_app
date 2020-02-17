require 'rails_helper'

# Implicitly subject:
RSpec.describe Array do
  describe "when first init" do
    it "should be empty" do
      expect(subject).to be_empty # subject ở đây là []
    end
  end
end

# Explicit subject:
RSpec.describe Array, "with some elements" do
  subject { [1, 2, 3] }

  it "has expected elements" do
    expect(subject).to eq([1, 2, 3]) # subject ở đây là [1, 2, 3]
  end
end

RSpec.describe User do
  describe User do
    before(:example) do
      @user = User.new
    end

    it "should have name" do
      @user.name = "Xuan Hieu"
      expect(@user.name).to eq("Xuan Hieu")
    end

    it "should hame email" do
      @user.email = "xhieu94@gmail.com"
      expect(@user.email).to eq("xhieu94@gmail.com")
    end
  end
end