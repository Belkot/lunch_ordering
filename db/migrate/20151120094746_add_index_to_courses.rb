class AddIndexToCourses < ActiveRecord::Migration
  def change
    add_index :courses, :deleted_at
  end
end
