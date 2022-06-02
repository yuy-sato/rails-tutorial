require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  describe "#home" do
    it "/へのgetリクエストが正常にレスポンスを返すこと" do
      get root_path
      expect(response).to have_http_status(200)
    end

    it "titleがRuby on Rails Tutorial Sample Appであること" do
      get root_path
      expect(response.body).to include "#{base_title}"
    end
  end

  describe "#help" do
    it "/helpへのgetリクエストが正常にレスポンスを返すこと" do
      get help_path
      expect(response).to have_http_status(200)
    end

    it "titleがHelp | Ruby on Rails Tutorial Sample Appであること" do
      get help_path
      expect(response.body).to include "Help | #{base_title}"
    end
  end

  describe "#about" do
    it "/aboutへのgetリクエストが正常にレスポンスを返すこと" do
      get about_path
      expect(response).to have_http_status(200)
    end

    it "titleがAbout | Ruby on Rails Tutorial Sample Appであること" do
      get about_path
      expect(response.body).to include "About | #{base_title}"
    end
  end

  describe "#contact" do
    it "/contactへのgetリクエストが正常にレスポンスを返すこと" do
      get contact_path
      expect(response).to have_http_status(200)
    end

    it "titleがContact | Ruby on Rails Tutorial Sample Appであること" do
      get contact_path
      expect(response.body).to include "Contact | #{base_title}"
    end
  end
end
