require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  let(:order) { create(:user).orders.create }

  describe "user access" do

    login_user

    describe "GET #index" do
      it "assigns all orders as @orders" do
        get :index
        expect(assigns(:orders)).to eq([order])
      end
    end

    describe "GET #show" do
      it "not the route" do
        expect(get: "/orders/#{order.id}").not_to be_routable
      end
    end

    describe "GET #new" do
      it "assigns a new order as @order" do
        get :new
        expect(assigns(:order)).to be_a_new(Order)
      end
    end

    describe "GET #edit" do
      it "not the route" do
        expect(get: "/orders/#{order.id}/edit").not_to be_routable
      end
    end

    describe "POST #create" do

      before do
        course_type1 = create(:course_type)
        course_type2 = create(:course_type)
        course_type3 = create(:course_type)
        course1 = create(:course, course_type_id: course_type1.id)
        course2 = create(:course, course_type_id: course_type2.id)
        course3 = create(:course, course_type_id: course_type3.id)
        @courses_attribute = {course1.name => course1.course_type.id,
                              course2.name => course2.course_type.id,
                              course3.name => course3.course_type.id
                             }
      end
      context "with valid params" do
        it "creates a new Order" do
          expect {
            post :create, Courses: @courses_attribute
          }.to change(Order, :count).by(1)
        end

        it "redirects to the created order" do
          post :create, Courses: @courses_attribute
          expect(response).to redirect_to(dashboard_path)
        end
      end

    end

    describe "PUT #update" do
      it "not the route" do
        expect(put: "/orders/#{order.id}").not_to be_routable
      end
    end

    describe "DELETE #destroy" do
      it "not the route" do
        expect(delete: "/orders/#{order.id}").not_to be_routable
      end
    end

  end

  describe "guest access" do

    it "GET #index denies access" do
      get :index
      expect(response).to redirect_to user_session_url
    end

    it "GET #menu denies access" do
      get :menu
      expect(response).to redirect_to user_session_url
    end

    it "GET #show not the route" do
      expect(get: "/orders/#{order.id}").not_to be_routable
    end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to user_session_url
    end

    it "GET #edit not the route" do
      expect(get: "/orders/#{order.id}/edit").not_to be_routable
    end

    it "POST #create denies access" do
      post :create
      expect(response).to redirect_to user_session_url
    end

    it "PUT #update not the route" do
      expect(update: "/orders/#{order.id}").not_to be_routable
    end

    it "DELETE #destroy not the route" do
      expect(update: "/orders/#{order.id}").not_to be_routable
    end

  end

end
