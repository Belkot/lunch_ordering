class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :course

  before_save :ensure_one_course_for_each_course_type_in_one_order

  private
    def ensure_one_course_for_each_course_type_in_one_order()
      if self.order.courses.exists?( course_type_id: self.course.course_type.id )
        self.errors.add :base, 'Only one course from each course types'
        return false
      else
        return true
      end
    end

end
