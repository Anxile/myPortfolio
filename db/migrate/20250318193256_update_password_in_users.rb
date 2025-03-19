class UpdatePasswordInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :password, :string
    rename_column :users, :password, :password_digest
  end
end
