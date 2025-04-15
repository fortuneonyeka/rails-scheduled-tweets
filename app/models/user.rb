# email:string
# password_digest:string
class User < ApplicationRecord
  has_secure_password

 validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
 validates :password, presence: true,
                       length: { minimum: 6 },
                       format: {
                         with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).+\z/,
                         message: "must include at least one lowercase letter, one uppercase letter, one digit, and one special character"
                       }
end
