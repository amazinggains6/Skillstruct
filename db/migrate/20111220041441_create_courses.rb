class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string    :name
      t.string    :place
      t.text      :description
      t.text      :credentials
      t.date      :startdate
      t.time      :starttime
      t.date      :enddate
      t.time      :endtime
      t.integer   :attendance
      t.integer   :cost
      t.integer   :user_id
      t.timestamps
    end
  end
end
