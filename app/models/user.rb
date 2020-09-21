class User < ActiveRecord::Base
  validates :first_name, :last_name, :password_confirmation, presence: true
  
  validates :password, presence: true, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
end
