class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path(name: "#{@user.first_name} #{@user.last_name}"), 
      notice: "Successfully added #{@user.first_name} #{@user.last_name} "
    else
      render :new, status: :unprocessable_entity
    end
  end


  def send_password_reset
    generate_password_reset_token
    UserMailer.password_reset(self).deliver_now
  end

  def generate_password_reset_token!
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
  end
  

  # Optional: Add a method to check if the token is expired
  def password_reset_expired?
    password_reset_sent_at < 2.hours.ago
  end


private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name) # Add other permitted attributes
  end
end
