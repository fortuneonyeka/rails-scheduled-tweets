class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :user_signed_in?
  
  before_action :verify_user_exists

  def authenticate_user!
    unless logged_in?
      redirect_to login_path, alert: "Please log in first"
    end
  end

  def logged_in?
    current_user.present?
  end

  # Alias for Devise-style compatibility
  alias_method :user_signed_in?, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    # Handle case where user ID exists but record was deleted
    session.delete(:user_id)
    nil
  end

  private

  def verify_user_exists
    if session[:user_id] && current_user.nil?
      reset_session
      redirect_to login_path, 
        alert: "Your account no longer exists. Please contact support if this is unexpected."
    end
  end
end
