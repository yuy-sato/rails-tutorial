require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { user.microposts.build(content: 'Lorem ipsum') }

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

  it "並び順は投稿の新しい順になっていること" do
    FactoryBot.send(:user_with_posts)
    expect(FactoryBot.create(:most_recent)).to eq Micropost.first
  end

  it "投稿したユーザが削除された場合、そのユーザのMicropostも削除されること" do
    post = FactoryBot.create(:most_recent)
    user = post.user
    expect {
      user.destroy
    }.to change(Micropost, :count).by -1
  end
end
