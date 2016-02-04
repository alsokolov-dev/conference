class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 50},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: true
  validates :organization_name, presence: true
  validates :department, presence: true
  validates :position, presence: true
  validates :presentation, presence: true
  validates :abstract, presence: true
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
end
