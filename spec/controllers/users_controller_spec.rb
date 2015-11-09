require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "administrator access" do

    login_admin
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns all users as @users" do
        get :index
        expect(assigns(:users)).to eq(User.all)
      end
    end

  end

  describe "user access" do
    login_user
    it "GET #index denies access" do
      get :index
      expect(response).to redirect_to root_url
    end
  end

  describe "guest access" do
    it "GET #index denies access" do
      get :index
      expect(response).to redirect_to user_session_url
    end
  end

end
