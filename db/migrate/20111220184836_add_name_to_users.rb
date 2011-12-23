class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :bio, :text
    add_column :users, :state, :string
    add_column :users, :zipcode, :string
  end
  
end
