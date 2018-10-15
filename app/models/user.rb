class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true


  def self.authenticate_with_credentials(email, password)
    if email.include?(' ')
      email = email.split(/[,\s]+/)
    end
    if email =~ /[A-Z]/
      email = email.downcase
    end
    user = User.find_by_email(email)
    user && user.authenticate(password) ? user : nil
  end

end
