require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.build(:micropost, content: 'Lorem ipsum', user:) }
  let(:most_recent) { FactoryBot.create(:most_recent) }

  it "should be valid" do
    expect(micropost).to be_valid
  end

  it "should be invalid if user_id is empty" do
    micropost.user_id = nil
    expect(micropost).to_not be_valid
  end

  describe "content" do
    it "should be invalid if content is empty" do
      micropost.content = ""
      expect(micropost).to_not be_valid
    end

    it "should be invalid if content is over 141 char" do
      micropost.content = "a" * 141
      expect(micropost).to_not be_valid
    end
  end

  context "並び順は投稿の新しい順になっていること" do
    before do
      FactoryBot.create_list(:orange, 5, user:)
    end

    it do
      expect(most_recent).to eq Micropost.first
    end
  end

  context "投稿したユーザが削除された場合" do
    before do
      FactoryBot.create(:most_recent, user:)
    end

    it "そのユーザのMicropostも削除されること" do
      expect {
        user.destroy
      }.to change(Micropost, :count).by -1
    end
  end
end
