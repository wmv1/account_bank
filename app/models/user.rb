class User < ApplicationRecord
  include BCrypt

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 6..10 }

  def valid_password?(user_password)
    user_password == user_password
  end

  def as_json(options = {})
    super(options.merge())
  end

  def user_password
    return nil unless self.password.present?
    @password ||= Password.new(password)
  end

  def user_password=(value)
    return unless value.present?
    @password = value
    self.password = Password.create(value)
  end
end
