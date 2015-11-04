class CourseType < ActiveRecord::Base
  validates :name, length: { in: 1..20 }
end
