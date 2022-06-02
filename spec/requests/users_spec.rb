require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#login" do
    let(:user) { FactoryBot.create(:user) }

    it "誤ったパスワードではログインできないこと" do
      get login_path
      post login_path, params: { 
        session: { 
          email: user.email, 
          password: "invalid"
        } 
      }
      expect(logged_in?).to_not be_truthy
    end

    it "誤ったパスワードではログインした場合dangerのフラッシュメッセージがでること" do
      get login_path
      post login_path, params: { 
        session: { 
          email: user.email, 
          password: "invalid"
        } 
      }
      expect(flash[:danger]).to be_present
    end

    it "正しいログイン情報でログインできること" do
      get login_path
      post login_path, params: { 
        session: { 
          email: user.email, 
          password: "password"
        } 
      }
      expect(logged_in?).to be_truthy
    end

    it "ログアウトできること" do
      get login_path
      post login_path, params: { 
        session: { 
          email: user.email, 
          password: "password"
        } 
      }
      expect(logged_in?).to be_truthy

      delete logout_path
      expect(logged_in?).to_not be_truthy
    end

  end
end
