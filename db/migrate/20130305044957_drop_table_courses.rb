class DropTableCourses < ActiveRecord::Migration
  def change
    drop_table :courses
  end
end
