class AddEmailAndNameToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :uemail, :string
    add_column :authentications, :uname, :string
  end
end
