class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def menu
    @date = params[:date]
    if @date
      @courses = Course.for_date(@date).group_by { |course| course.course_type }
    else
      @courses = Course.today.group_by { |course| course.course_type }
    end
  end

  def new
    @order = Order.new
    @courses = Course.today.group_by { |course| course.course_type }
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
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:Courses).permit!
    end
end
