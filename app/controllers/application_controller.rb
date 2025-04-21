class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :current_user

  def authenticate_user!
    unless current_user
      reset_session
      redirect_to login_path, alert: "Please log in"
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) # Using find_by instead of find
  end
  helper_method :current_user

  def require_user
    redirect_to login_path, alert: "You must be logged in" unless current_user
  end
end
