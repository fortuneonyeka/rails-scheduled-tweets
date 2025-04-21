# app/controllers/home_controller.rb
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.nil?
      reset_session
      redirect_to login_path, alert: "Session expired. Please log in again."
    else
      # Your normal index action
    end
  end
end