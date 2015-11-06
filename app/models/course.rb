class Course < ActiveRecord::Base
  belongs_to :course_type, inverse_of: :courses
  has_many :line_items
  has_many :orders, through: :line_items

  validates :course_type, presence: true
  validates :name, length: { in: 3..30 }, presence: true
  validates :price, numericality: true, presence: true

  before_update :updater
  before_destroy :deleter
  after_rollback :saver_self, only: :destroy

  scope :today, -> { where(deleted_at: nil) }

  private

    def updater
      unless @flag_delete
        new_course = Course.new( name: name, price: price, course_type_id: course_type_id )
        reload
        unless new_course.name == name && new_course.price == price && new_course.course_type_id == course_type_id
          deleted_at = DateTime.now
          new_course.save
        end
      end
    end

    def deleter
      @flag_delete = true
      false
    end

    def saver_self
      if @flag_delete
        deleted_at = DateTime.now
        save
      end
    end
end
