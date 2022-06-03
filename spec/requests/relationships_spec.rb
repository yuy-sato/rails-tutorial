require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "#create" do
    let(:user) { FactoryBot.create(:user) }
    let(:other) { FactoryBot.create(:archer) }

    context "not logged in" do
      it "redirect to login_path" do
        post relationships_path
        expect(response).to redirect_to login_path
      end

      it "should not create" do
        expect {
          post relationships_path
        }.to_not change(Relationship, :count)
      end
      
      it "should create" do
        log_in user
        expect{
          post relationships_path, params: { followed_id: other.id }
        }.to change(Relationship, :count).by 1
      end

      it "should create if use ajax" do
        log_in user
        expect {
          post relationships_path, params: { followed_id: other.id }, xhr: true
        }.to change(Relationship, :count).by 1
      end
    end
  end
end
