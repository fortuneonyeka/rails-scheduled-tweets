class User < ApplicationRecord
  has_secure_password
  before_destroy :clear_sessions
  has_one_attached :avatar
  has_many :tweets, dependent: :destroy

  def avatar_url
    return default_avatar_url unless ActiveRecord::Base.connection.table_exists?('active_storage_attachments')

    avatar.attached? ? avatar : default_avatar_url
  rescue ActiveRecord::StatementInvalid
    default_avatar_url
  end
  # Email validations
  validates :email, 
    presence: { message: "can't be blank" },
    uniqueness: { case_sensitive: false, message: "is already taken" },
    format: { 
      with: URI::MailTo::EMAIL_REGEXP, 
      message: "must be a valid email address" 
    },
    length: { 
      maximum: 255, 
      message: "is too long (maximum is 255 characters)" 
    }

  # Name validations
  validates :first_name, 
    presence: { message: "can't be blank" },
    length: { 
      maximum: 50, 
      message: "is too long (maximum is 50 characters)" 
    },
    format: {
      with: /\A[a-zA-Z\s'-]+\z/,
      message: "can only contain letters, spaces, hyphens, and apostrophes"
    }

  validates :last_name, 
    presence: { message: "can't be blank" },
    length: { 
      maximum: 50, 
      message: "is too long (maximum is 50 characters)" 
    },
    format: {
      with: /\A[a-zA-Z\s'-]+\z/,
      message: "can only contain letters, spaces, hyphens, and apostrophes"
    }

  # Password validations
  validates :password,
    presence: { message: "can't be blank" },
    length: { 
      minimum: 8, 
      maximum: 128,
      too_short: "is too short (minimum is 8 characters)",
      too_long: "is too long (maximum is 128 characters)"
    },
    format: {
      with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).+\z/,
      message: "must include at least: 1 uppercase, 1 lowercase, 1 digit, and 1 special character (@$!%*?&)"
    },
    allow_nil: true # Allows blank passwords when updating other attributes

  # Password confirmation validation
  validates :password_confirmation, 
    presence: { message: "can't be blank" },
    if: -> { password.present? }


    # Add password reset methods
  def create_password_reset_token
    self.password_reset_token = generate_token
    self.password_reset_sent_at = Time.zone.now
    save!
  end

  def send_password_reset_email
    create_password_reset_token
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    password_reset_sent_at < 2.hours.ago
  end

  private

  def generate_token
    SecureRandom.urlsafe_base64
  end

  # def send_password_reset
  #   generate_token(:password_reset_token)
  #   self.password_reset_sent_at = Time.zone.now
  #   save!
  #   UserMailer.password_reset(self).deliver_now
  # end
  
  # def generate_token(column)
  #   begin
  #     self[column] = SecureRandom.urlsafe_base64
  #   end while User.exists?(column => self[column])
 

  private

  def default_avatar_url
    identifier = email.present? ? email.downcase : id
    hash = Digest::MD5.hexdigest(identifier.to_s)
    "https://i.pravatar.cc/300?u=#{hash}"
  end
  def clear_sessions
    # Clear any active sessions for this user
    Session.where(user_id: id).delete_all if defined?(Session)
  end
  
end

