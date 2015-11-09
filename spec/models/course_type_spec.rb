require 'rails_helper'

RSpec.describe CourseType, type: :model do

  it "is valid with a name" do
    course_type = CourseType.new(name: "Main")
    expect(course_type).to be_valid
  end

  context "is invalid" do

    it "without a name" do
      course_type = CourseType.new
      course_type.valid?
      expect(course_type.errors[:name]).to include("can't be blank", "is too short (minimum is 1 character)")
    end

    it "with a short name" do
      course_type = CourseType.new(name: "")
      course_type.valid?
      expect(course_type.errors[:name]).to include("is too short (minimum is 1 character)")
    end

    it "with a long name" do
      long_name = 'a' * 21
      course_type = CourseType.new(name: long_name)
      course_type.valid?
      expect(course_type.errors[:name]).to include("is too long (maximum is 20 characters)")
    end

  end

end
