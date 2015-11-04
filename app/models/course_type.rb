class CourseType < ActiveRecord::Base
  has_many :courses, inverse_of: :course_type

  validates :name, length: { in: 1..20 }
end
