# app/controllers/password_resets_controller.rb
class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_password_reset_token!
      UserMailer.password_reset(@user).deliver_now
      redirect_to root_url, notice: "Email sent with password reset instructions"
    else
      flash.now[:alert] = "Email not found"
      render :new
    end
  end

  def edit
    # @user is set by get_user before_action
  end

  def update
    if @user.update(user_params)
      @user.update(password_reset_token: nil, password_reset_sent_at: nil)
      redirect_to login_path, notice: "Password has been reset"
    else
      render :edit
    end
  end

  private

  def get_user
    @user = User.find_by(password_reset_token: params[:id])
    unless @user
      redirect_to new_password_reset_path, alert: "Invalid password reset link"
    end
  end

  def valid_user
    unless @user&.activated?
      redirect_to root_url, alert: "Account not activated"
    end
  end

  def check_expiration
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired"
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end