require 'byebug'

class User < ActiveRecord::Base
  attr_reader :password
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :set_session_token

  has_many :cats
  has_many :rental_requests,
    class_name: 'CatRentalRequest',
    foreign_key: :user_id

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  def is_password?(password)
    self.password_digest.is_password?(password)
  end

  private

  def set_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

end
