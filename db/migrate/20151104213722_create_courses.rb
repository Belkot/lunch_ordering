class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.float :price
      t.references :course_type, index: true, foreign_key: true
      t.datetime :deleted_at, default: nil, null: true

      t.timestamps null: false
    end
  end
end
