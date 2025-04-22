class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :user_signed_in?
  
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
  end
end