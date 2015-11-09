require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "administrator access" do

    login_admin
    it "GET #index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

  end

  describe "user access" do

    login_user
    it "GET #index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

  end

  describe "guest access" do
    it "GET #index denies access" do
      get :index
      expect(response).to redirect_to user_session_url
    end

  end

end
