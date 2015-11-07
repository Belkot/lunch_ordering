class Course < ActiveRecord::Base
  belongs_to :course_type, inverse_of: :courses
  has_many :line_items
  has_many :orders, through: :line_items

  validates :course_type, presence: true
  validates :name, length: { in: 3..30 }, presence: true
  validates :price, numericality: true, presence: true

  scope :today, -> { where(deleted_at: nil) }
  scope :for_date, ->(date) { where("created_at < ?", date).
                              where("deleted_at < ? OR deleted_at IS NULL", date)
                            }

  def destroy_saver
    self.deleted_at = DateTime.now
    self.save
  end

  def update_saver(arg)
    Course.create( name: arg['name'] || self.name,
                  price: arg['price'] || self.price,
         course_type_id: arg['course_type_id'] || self.course_type_id )
    self.reload
    self.destroy_saver
  end

end
