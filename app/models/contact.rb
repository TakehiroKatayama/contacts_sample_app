class Contact < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\d{10,11}\z/

  validates :name, length: { maximum: 48 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 256 }
  validates :phonenumber, presence: true, format: { with: VALID_PHONE_REGEX }
  validates :message, presence: true, length: { maximum: 2000 }
  validates :remote_ip, presence: true
end
