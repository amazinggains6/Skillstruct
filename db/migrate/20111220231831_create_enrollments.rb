class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :course
      t.references :user
      t.boolean :active, :default => true
      t.timestamps
      t.timestamps
    end
    add_index :enrollments, :course_id
    add_index :enrollments, :user_id
    add_index :enrollments, [:course_id, :user_id], :unique => true
  end
end
