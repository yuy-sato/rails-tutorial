require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  describe "#create" do
    context "not logged in" do
      it "should not register" do
        expect {
          post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
        }.to_not change(Micropost, :count)
      end

      it "should redirect to login page" do
        post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#destroy' do
    let(:user) { FactoryBot.create(:archer) }
    let!(:micropost) { FactoryBot.create(:most_recent) }
 
    context '他のユーザの投稿を削除した場合' do
      before do
        log_in user
      end
 
      it '削除されないこと' do
        expect {
          delete micropost_path(micropost)
        }.to_not change(Micropost, :count)
      end
 
      it 'ホームページにリダイレクトされること' do
        delete micropost_path(micropost)
        expect(response).to redirect_to root_path
      end
    end
 
    context '未ログインの場合' do
      it '削除されないこと' do
        expect {
          delete micropost_path(micropost)
        }.to_not change(Micropost, :count)
      end
 
      it 'ログインページにリダイレクトされること' do
        delete micropost_path(micropost)
        expect(response).to redirect_to login_path
      end
    end
  end
end
