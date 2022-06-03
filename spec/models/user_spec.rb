require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.new(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  }

  it 'userが有効であること' do
    expect(user).to be_valid
  end

  it 'nameが必須であること' do
    user.name = ''
    expect(user).to_not be_valid
  end

  it 'emailが必須であること' do
    user.email = ''
    expect(user).to_not be_valid
  end

  it 'nameが50文字以内であること' do
    user.name = 'a' * 51
    expect(user).to_not be_valid
  end

  it 'emailが255文字以内であること' do
    user.email = "#{'a' * 256}@mail.com"
    expect(user).to_not be_valid
  end

  it 'emailがユニークであること' do
    dup_user = user.dup
    user.save
    expect(dup_user).to_not be_valid
  end

  it 'emailがユニークであること' do
    dup_user = user.dup
    dup_user.email = user.email.upcase
    user.save
    expect(dup_user).to_not be_valid
  end

  describe "#follow #unfollow" do
    let(:user) { FactoryBot.create(:user) }
    let(:other) { FactoryBot.create(:archer) }

    it "should following? is true when follow" do
      expect(user.following?(other)).to_not be_truthy
      user.follow(other)
      expect(other.followers.include?(user)).to be_truthy
      expect(user.following?(other)).to be_truthy
    end

    it "should following? is false when unfollow" do
      user.follow(other)
      expect(user.following?(other)).to_not be_falsey
      user.unfollow(other)
      expect(user.following?(other)).to be_falsey
    end
  end
end
