require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe CourseTypesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # CourseType. As you add validations to CourseType, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CourseTypesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all course_types as @course_types" do
      course_type = CourseType.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:course_types)).to eq([course_type])
    end
  end

  describe "GET #show" do
    it "assigns the requested course_type as @course_type" do
      course_type = CourseType.create! valid_attributes
      get :show, {:id => course_type.to_param}, valid_session
      expect(assigns(:course_type)).to eq(course_type)
    end
  end

  describe "GET #new" do
    it "assigns a new course_type as @course_type" do
      get :new, {}, valid_session
      expect(assigns(:course_type)).to be_a_new(CourseType)
    end
  end

  describe "GET #edit" do
    it "assigns the requested course_type as @course_type" do
      course_type = CourseType.create! valid_attributes
      get :edit, {:id => course_type.to_param}, valid_session
      expect(assigns(:course_type)).to eq(course_type)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new CourseType" do
        expect {
          post :create, {:course_type => valid_attributes}, valid_session
        }.to change(CourseType, :count).by(1)
      end

      it "assigns a newly created course_type as @course_type" do
        post :create, {:course_type => valid_attributes}, valid_session
        expect(assigns(:course_type)).to be_a(CourseType)
        expect(assigns(:course_type)).to be_persisted
      end

      it "redirects to the created course_type" do
        post :create, {:course_type => valid_attributes}, valid_session
        expect(response).to redirect_to(CourseType.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved course_type as @course_type" do
        post :create, {:course_type => invalid_attributes}, valid_session
        expect(assigns(:course_type)).to be_a_new(CourseType)
      end

      it "re-renders the 'new' template" do
        post :create, {:course_type => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested course_type" do
        course_type = CourseType.create! valid_attributes
        put :update, {:id => course_type.to_param, :course_type => new_attributes}, valid_session
        course_type.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested course_type as @course_type" do
        course_type = CourseType.create! valid_attributes
        put :update, {:id => course_type.to_param, :course_type => valid_attributes}, valid_session
        expect(assigns(:course_type)).to eq(course_type)
      end

      it "redirects to the course_type" do
        course_type = CourseType.create! valid_attributes
        put :update, {:id => course_type.to_param, :course_type => valid_attributes}, valid_session
        expect(response).to redirect_to(course_type)
      end
    end

    context "with invalid params" do
      it "assigns the course_type as @course_type" do
        course_type = CourseType.create! valid_attributes
        put :update, {:id => course_type.to_param, :course_type => invalid_attributes}, valid_session
        expect(assigns(:course_type)).to eq(course_type)
      end

      it "re-renders the 'edit' template" do
        course_type = CourseType.create! valid_attributes
        put :update, {:id => course_type.to_param, :course_type => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested course_type" do
      course_type = CourseType.create! valid_attributes
      expect {
        delete :destroy, {:id => course_type.to_param}, valid_session
      }.to change(CourseType, :count).by(-1)
    end

    it "redirects to the course_types list" do
      course_type = CourseType.create! valid_attributes
      delete :destroy, {:id => course_type.to_param}, valid_session
      expect(response).to redirect_to(course_types_url)
    end
  end

end