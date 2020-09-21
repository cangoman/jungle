class User < ActiveRecord::Base
  validates :first_name, :last_name, :password, :password_confirmation, presence: true
  
  validates :email , presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
end
