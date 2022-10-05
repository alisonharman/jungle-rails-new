class User < ApplicationRecord

  has_secure_password
  validates_presence_of :password_confirmation
    validates :password, length: { in: 6..72 }
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :email

end
