require 'rails_helper'

RSpec.describe CourseTypesController, type: :controller do

  let(:valid_attributes) { attributes_for(:course_type) }

  let(:invalid_attributes) { attributes_for(:course_type, name: nil) }

  let(:course_type) { CourseType.create! valid_attributes }

  describe "administrator access" do

    login_admin

    describe "GET #index" do
      it "assigns all course_types as @course_types" do
        get :index
        expect(assigns(:course_types)).to eq([course_type])
      end
    end

    describe "GET #show" do
      it "not the route" do
        expect(get: "/course_types/#{course_type.id}").not_to be_routable
      end
    end

    describe "GET #new" do
      it "assigns a new course_type as @course_type" do
        get :new
        expect(assigns(:course_type)).to be_a_new(CourseType)
      end
    end

    describe "GET #edit" do
      it "assigns the requested course_type as @course_type" do
        get :edit, id: course_type.to_param
        expect(assigns(:course_type)).to eq(course_type)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new CourseType" do
          expect {
            post :create, course_type: valid_attributes
          }.to change(CourseType, :count).by(1)
        end

        it "assigns a newly created course_type as @course_type" do
          post :create, course_type: valid_attributes
          expect(assigns(:course_type)).to be_a(CourseType)
          expect(assigns(:course_type)).to be_persisted
        end

        it "redirects to the course_types" do
          post :create, course_type: valid_attributes
          expect(response).to redirect_to(course_types_path)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved course_type as @course_type" do
          post :create, course_type: invalid_attributes
          expect(assigns(:course_type)).to be_a_new(CourseType)
        end

        it "re-renders the 'new' template" do
          post :create, course_type: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { {name: "New type course"} }

        it "updates the requested course_type" do
          put :update, id: course_type.to_param, course_type: new_attributes
          course_type.reload
          expect(course_type.name).to eq("New type course")
        end

        it "assigns the requested course_type as @course_type" do
          put :update, id: course_type.to_param, course_type: valid_attributes
          expect(assigns(:course_type)).to eq(course_type)
        end

        it "redirects to the course_types" do
          put :update, id: course_type.to_param, course_type: valid_attributes
          expect(response).to redirect_to(course_types_path)
        end
      end

      context "with invalid params" do
        it "assigns the course_type as @course_type" do
          put :update, id: course_type.to_param, course_type: invalid_attributes
          expect(assigns(:course_type)).to eq(course_type)
        end

        it "re-renders the 'edit' template" do
          put :update, id: course_type.to_param, course_type: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "not the route" do
        expect(delete: "/course_types/#{course_type.id}").not_to be_routable
      end
    end
  end

  describe "user access" do

    login_user

    it "GET #index denies access" do
      get :index
      expect(response).to redirect_to root_url
    end

    it "GET #show not the route" do
      expect(get: "/course_types/#{course_type.id}").not_to be_routable
    end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to root_url
    end

    it "GET #edit denies access" do
      get :edit, id: course_type.to_param
      expect(response).to redirect_to root_url
    end

    it "POST #create denies access" do
      post :create, course_type: valid_attributes
      expect(response).to redirect_to root_url
    end

    it "PUT #update denies access" do
      put :update, id: course_type.to_param, course_type: {name: "New type course"}
      expect(response).to redirect_to root_url
    end

    it "DELETE #destroy not the route" do
      expect(delete: "/course_types/#{course_type.id}").not_to be_routable
    end

  end

  describe "guest access" do

    it "GET #index denies access" do
      get :index
      expect(response).to redirect_to user_session_url
    end

    it "GET #show not the route" do
        expect(get: "/course_types/#{course_type.id}").not_to be_routable
      end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to user_session_url
    end

    it "GET #edit denies access" do
      get :edit, id: course_type.to_param
      expect(response).to redirect_to user_session_url
    end

    it "POST #create denies access" do
      post :create, course_type: valid_attributes
      expect(response).to redirect_to user_session_url
    end

    it "PUT #update denies access" do
      put :update, id: course_type.to_param, course_type: {name: "New type course"}
      expect(response).to redirect_to user_session_url
    end

    it "DELETE #destroy not the route" do
      expect(delete: "/course_types/#{course_type.id}").not_to be_routable
    end

  end

end
