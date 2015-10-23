class User < ActiveRecord::Base

  validates :email, :password_digest, :session_token, :username, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  before_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?

    if user.is_password?(password)
      user
    else
      nil
    end    
  end

  def password=(password)
    @password = password
    password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  def is_password?(password)
    password_digest.is_password?(password)
  end

  def generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    session_token = generate_session_token
  end

  private

    def ensure_session_token
      session_token ||= generate_session_token
    end

end
