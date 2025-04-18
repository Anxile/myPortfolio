class RenameMailToEmailInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :mail, :email
  end
end
