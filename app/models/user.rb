class User < ApplicationRecord
  include BCrypt

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 6..10 }

  def valid_password?(user_password)
    user_password == user_password
  end

  private

  def user_password
    return nil unless self.password.present?
    @password ||= Password.new(password)
  end
end
