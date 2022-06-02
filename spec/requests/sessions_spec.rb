require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it "should get new" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  # describe 'DELETE /logout' do
  #   before do
  #     user = FactoryBot.create(:user)
  #     post login_path, params: { session: { email: user.email, password: user.password } }
  #   end

  #   it 'user logged out' do
  #     expect(logged_in?).to be_truthy
 
  #     delete logout_path
  #     expect(logged_in?).to_not be_truthy
  #   end
  # end

  describe "#create" do
    let(:user) { FactoryBot.create(:user) }

    describe "remember me" do
      it "if remember me is on, remember token is not empty" do
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password,
            remember_me: 1
          }
        }
        expect(cookies[:remember_token]).to_not be_blank
      end

      it "if remember me is off, remember token is empty" do
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password,
            remember_me: 0
          }
        }
        expect(cookies[:remember_token]).to be_blank
      end
    end
  end
end
