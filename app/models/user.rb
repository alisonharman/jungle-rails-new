class User < ApplicationRecord

  has_secure_password
  validates_presence_of :password_confirmation
  validates :password, length: { in: 6..72 }
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  before_save { |user| user.email = email.downcase}

  def self.authenticate_with_credentials email, password
    # find the User first User.find_by(email: email)
    # User.authenticate(password) -> evaluates to true or false
    self.find_by(email: email.downcase.strip).try(:authenticate, password)
end
end
