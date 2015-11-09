require 'rails_helper'

RSpec.describe User, type: :model do

  it "first added be admin" do
    user1 = create(:user)
    user2 = create(:user)
    expect(user1.admin?).to be_truthy
    expect(user2.admin?).to be_falsey
  end

  it "is valid with a name" do
    expect(build(:user)).to be_valid
  end

  context "is invalid" do

    it "without a name" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "with a short name" do
      user = build(:user, name: 'Ab')
      user.valid?
      expect(user.errors[:name]).to include("is too short (minimum is 3 characters)")
    end

    it "with a long name" do
      long_name = 'a' * 21
      user = build(:user, name: long_name)
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

  end

end
