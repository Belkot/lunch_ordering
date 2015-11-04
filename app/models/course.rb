class Course < ActiveRecord::Base
  belongs_to :course_type, inverse_of: :courses
end
