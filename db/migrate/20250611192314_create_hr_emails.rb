class CreateHrEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :hr_emails do |t|
      t.string :email
      t.timestamps
    end
  end
end
