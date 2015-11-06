class CourseTypesController < ApplicationController

  def index
    @course_types = CourseType.all
  end

  def new
    @course_type = CourseType.new
  end

  def edit
    @course_type = CourseType.find(params[:id])
  end

  def create
    @course_type = CourseType.new(course_type_params)

    if @course_type.save
      redirect_to course_types_url, notice: 'Course type was successfully created.'
    else
      render :new
    end
  end

  def update
    @course_type = CourseType.find(params[:id])

    if @course_type.update(course_type_params)
      redirect_to course_types_url, notice: 'Course type was successfully updated.'
    else
      render :edit
    end
  end

  private

    def course_type_params
      params.require(:course_type).permit(:name)
    end
end
