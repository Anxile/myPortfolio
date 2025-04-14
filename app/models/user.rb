class User < ApplicationRecord
  self.table_name = 'users'
  has_secure_password
  has_one :status, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
end
