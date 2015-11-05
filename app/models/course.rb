class Course < ActiveRecord::Base
  belongs_to :course_type, inverse_of: :courses
  has_many :line_items
  has_many :orders, through: :line_items

  before_update :updater
  before_destroy :deleter
  after_rollback :saver_self

  private

    def updater
      Course.create( name: name, price: price, course_type_id: course_type_id )
      self.reload
      self.deleted_at = DateTime.now
    end

    def deleter
      false
    end

    def saver_self
      self.deleted_at = DateTime.now
      self.save
    end
end
