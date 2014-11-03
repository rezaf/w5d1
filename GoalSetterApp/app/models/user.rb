class User < ActiveRecord::Base
  
  after_initialize :ensure_session_token
  
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum:6, allow_null: true }
  
  attr_reader :password
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  private
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
