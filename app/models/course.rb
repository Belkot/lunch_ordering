class Course < ActiveRecord::Base
  belongs_to :course_type, inverse_of: :courses
  has_many :line_items
  has_many :orders, through: :line_items
end
