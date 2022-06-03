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

  describe "#destroy" do
    let(:user) { FactoryBot.create(:archer) }

    before do
      @post = FactoryBot.create(:most_recent)
    end

    context "destroy other users micropost" do
      before do
        log_in user
      end

      it "should not delete" do
        expect {
          delete micropost_path(@post)
        }.to_not change(Micropost, :count)
      end

      it "should redirect to login page" do
        delete micropost_path(@post)
        expect(response).to redirect_to login_path
      end
    end

    context "not logged in" do
      it "should not delete" do
        expect {
          delete micropost_path(@post)
        }.to_not change(Micropost, :count)
      end

      it "should redirect to login page" do
        delete micropost_path(@post)
        expect(response).to redirect_to login_path
      end
    end
  end
end
