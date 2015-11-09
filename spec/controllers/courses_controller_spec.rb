require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

  before do
    @course_type = create(:course_type)
  end
  let(:valid_attributes) { attributes_for(:course, course_type_id: @course_type.id) }

  let(:invalid_attributes) { attributes_for(:course, name: nil) }

  let(:course) { Course.create! valid_attributes }
  # let(:course) { create(:course) }

  describe "administrator access" do

    login_admin

    describe "GET #index" do
      it "assigns all courses as @courses" do
        get :index
        expect(assigns(:courses)).to eq([course])
      end
    end

    describe "GET #show" do
      it "not the route" do
        expect(get: "/courses/#{course.id}").not_to be_routable
      end
    end

    describe "GET #new" do
      it "assigns a new course as @course" do
        get :new
        expect(assigns(:course)).to be_a_new(Course)
      end
    end

    describe "GET #edit" do
      it "assigns the requested course as @course" do
        get :edit, id: course.to_param
        expect(assigns(:course)).to eq(course)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Course" do
          expect {
            post :create, course: valid_attributes
          }.to change(Course, :count).by(1)
        end

        it "assigns a newly created course as @course" do
          post :create, course: valid_attributes
          expect(assigns(:course)).to be_a(Course)
          expect(assigns(:course)).to be_persisted
        end

        it "redirects to the created course" do
          post :create, course: valid_attributes
          expect(response).to redirect_to(courses_path)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved course as @course" do
          post :create, course: invalid_attributes
          expect(assigns(:course)).to be_a_new(Course)
        end

        it "re-renders the 'new' template" do
          post :create, course: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { name: "New course", price: 6, course_type_id: @course_type.id } }

        it "updates the requested course" do
          put :update, id: course.to_param, course: new_attributes
          course.reload
          expect(course.deleted_at).to be_within(1.second).of(Time.now)
          expect(Course.last.name).to eq("New course")
        end

        it "assigns the requested course as @course" do
          put :update, id: course.to_param, course: valid_attributes
          expect(assigns(:course)).to eq(course)
        end

        it "redirects to the course" do
          put :update, id: course.to_param, course: valid_attributes
          expect(response).to redirect_to(courses_path)
        end
      end

      context "with invalid params" do
        it "assigns the course as @course" do
          put :update, id: course.to_param, course: invalid_attributes
          expect(assigns(:course)).to eq(course)
        end

        it "redirects to the course" do
          put :update, id: course.to_param, course: invalid_attributes
          expect(response).to redirect_to courses_path
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested course" do
        course = Course.create! valid_attributes
        expect {
          delete :destroy, id: course.to_param
        }.to change(Course, :count).by(0)
      end

      it "redirects to the courses list" do
        delete :destroy, id: course.to_param
        expect(response).to redirect_to(courses_url)
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
        expect(get: "/courses/#{course.id}").not_to be_routable
      end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to root_url
    end

    it "GET #edit denies access" do
      get :edit, id: course.to_param
      expect(response).to redirect_to root_url
    end

    it "POST #create denies access" do
      post :create, course: valid_attributes
      expect(response).to redirect_to root_url
    end

    it "PUT #update denies access" do
      put :update, id: course.to_param, course: {name: "New course"}
      expect(response).to redirect_to root_url
    end

    it "DELETE #destroy denies access" do
      delete :destroy, {id: course.to_param}
      expect(response).to redirect_to root_url
    end

  end

  describe "guest access" do

    it "GET #index denies access" do
      get :index
      expect(response).to redirect_to user_session_url
    end

    it "GET #show not the route" do
        expect(get: "/courses/#{course.id}").not_to be_routable
      end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to user_session_url
    end

    it "GET #edit denies access" do
      get :edit, id: course.to_param
      expect(response).to redirect_to user_session_url
    end

    it "POST #create denies access" do
      post :create, course: valid_attributes
      expect(response).to redirect_to user_session_url
    end

    it "PUT #update denies access" do
      put :update, id: course.to_param, course: {name: "New course"}
      expect(response).to redirect_to user_session_url
    end

    it "DELETE #destroy denies access" do
      delete :destroy, {id: course.to_param}
      expect(response).to redirect_to user_session_url
    end

  end

end
