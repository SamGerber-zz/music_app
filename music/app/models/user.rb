# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_initialize :ensure_session_token

  # Generate a random token
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  # Fetches a user by email and password, returning nil when none are found
  def self.find_by_credentials(email:, password:)
    user = User.find_by(email: email)
    return user if user.exists? && user.is_password?(password)
  end

  # Sets a new session_token and saves the user
  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
  end

  # If the user does not yet have a session_token, one is generated
  def ensure_session_token
    reset_session_token! unless session_token
  end

  # Creates password digest
  def password=(object)
    @password = String(object)
    self.password_digest = String(BCrypt::Password.create(@password))
  end

  # Checks if the input creates the correct digest.
  def is_password?(object)
    BCrypt::Password.new(password_digest).is_password?(String(object))
  end
end
