class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 10, message: "must be atleast 10 characters"}
  validates :username, presence: true, length: { in: 5..15, message: "must be between 5 to 15 characters" }, uniqueness: true
  validates :phone, presence: true, length: { is: 10, message: "must be only 10 characters" }, numericality: { only_integer: true, message: "should be a number" }, uniqueness: true
  validates :email, presence: true, format: { with: /\b[A-Z0-9a-z\-._%]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: "should be valid" }, uniqueness: true
end
