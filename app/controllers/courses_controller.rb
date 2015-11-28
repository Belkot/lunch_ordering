class CoursesController < ApplicationController
  before_action :authenticate_user!, :ensure_admin!
  before_action :set_course, only: [:edit, :update, :destroy]

  def index
    @courses = Course.today
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_url, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def update
    if @course.update_saver(course_params)
      redirect_to courses_url, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy_saver
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :price, :course_type_id)
  end
end
