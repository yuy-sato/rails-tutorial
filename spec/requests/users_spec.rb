require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "should get new" do
      get signup_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users #create" do
    it "invalid signup information" do
      expect {
        post users_path, params: {
          user: {
            name: "",
            email: "user@invalid",
            password: "foo",
            password_confirmation: "bar"
          }
        }
      }.to_not change(User, :count)
    end
  end

  context "valid signup information" do
    let(:user_params) {
      {
        user: {
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    }
    
    it "create user" do
      expect {
        post users_path, params: user_params
      }.to change(User, :count).by 1
    end

    # ログイン状態とアクティベートされているかなどの考慮が必要
    # it "redirect to users/show" do
    #   post users_path, params: user_params
    #   user = User.last
    #   expect(response).to redirect_to user
    # end

    # it 'flashが表示されること' do
    #   post users_path, params: user_params
    #   expect(flash).to be_any
    # end

    # it "logged in" do
    #   post users_path, params: user_params
    #   expect(logged_in?).to be_truthy
    # end
  end
end
