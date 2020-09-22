class User < ActiveRecord::Base
  validates :first_name, :last_name, :password_confirmation, presence: true
  
  validates :password, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password

  # before_save :email.downcase

  def self.authenticate_with_credentials email, password
    @user = User.find_by_email(email.strip.downcase);
    
    if @user && @user.authenticate(password.strip)
      @user
    else
      nil
    end
  end

end
