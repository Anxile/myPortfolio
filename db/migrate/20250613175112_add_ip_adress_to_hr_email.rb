class AddIpAdressToHrEmail < ActiveRecord::Migration[7.1]
  def change
    add_column :hr_emails, :ip_address, :string, default: ''
    add_column :hr_emails, :user_agent, :string, default: ''
  end
end
