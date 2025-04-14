class ApiUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  self.table_name = 'users'
  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  has_one :status, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
end
