class User < ApplicationRecord
  has_secure_password
  has_many :posts

  validates :name, presence: true, length: {in: 3..20}
  VALID_EMAIL_FORMAT= /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates email, presence: true, length: {maximum: 260}, format: { with: VALID_EMAIL_FORMAT}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {in: 8..20}
  before_save { self.email = email.downcase }

end
