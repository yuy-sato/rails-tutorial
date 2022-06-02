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

  describe "#authenticated?" do
    it "return false if digest is nil" do
      expect(user.authenticated?('')).to be_falsy
    end
  end
end
