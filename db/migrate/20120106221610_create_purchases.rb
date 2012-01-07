class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :teacher_id
      t.integer :amount
      t.boolean :completed, :default => false
      t.timestamps
    end
  end
end
