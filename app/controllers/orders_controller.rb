class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!, only: :index

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @orders = Order.where(created_at: @date..(@date + 1.day))
  end

  def menu
    @date = params[:date]
    @courses = if @date
                 Course.for_date(@date).group_by(&:course_type)
               else
                 Course.today.group_by(&:course_type)
               end
  end

  def new
    @order = Order.new
    @courses = Course.today.group_by(&:course_type)
  end

  def create
    order = current_user.orders.new
    course_ids = order_params.values
    order.courses << Course.today.find(course_ids)
    if order.save
      redirect_to dashboard_url, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:Courses).permit!
  end
end
