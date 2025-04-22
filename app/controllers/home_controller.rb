class HomeController < ApplicationController
  # Remove the Devise-specific line
  # skip_before_action :authenticate_user!, only: [:index]

  def index
    if logged_in? # Replace with your authentication method
      @user = current_user
      render :dashboard
    else
      render :landing
    end
  end

  private

  def logged_in?
    # Implement your own authentication check
    session[:user_id].present?
  end

  def current_user
    # Implement your own current user method
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
