class RemoveMakeFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :make, :string
  end
end
