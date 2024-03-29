class User < ActiveRecord::Base
  
    attr_reader :password
  
  after_initialize :ensure_session_token
  
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum:6, allow_nil: true }
  validates :session_token, uniqueness: true

  has_many(
    :goals,
    class_name: "Goal",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  )
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user.try(:valid_password?, password) ? user : nil
  end
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
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
