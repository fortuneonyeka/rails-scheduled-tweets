class HomeController < ApplicationController
  
  before_action :load_dashboard_data, only: [:index]
  

  def index
    if logged_in? 
      @user = current_user
      load_dashboard_data
      render :dashboard
    else
      render :landing
    end
  end

  

  private
  def load_dashboard_data
    return unless logged_in? # Safety check
    
    @scheduled_tweets_count = current_user.tweets.scheduled.count
    @impressions = current_user.tweets.sum(:impressions_count)
    @likes = current_user.tweets.sum(:likes_count)
    @upcoming_tweets = current_user.tweets.scheduled.order(scheduled_at: :asc).limit(10)
    
    # Calculate engagement metrics
    calculate_engagement_metrics
  end

  def calculate_engagement_metrics
    total_engagements = current_user.tweets.sum(:likes_count) + current_user.tweets.sum(:retweets_count)
    total_impressions = [current_user.tweets.sum(:impressions_count), 1].max # Avoid division by zero
    
    @engagement_rate = (total_engagements.to_f / total_impressions * 100).round(1)

    @engagement_trend = rand(1..10) # Placeholder - implement your actual trend calculation
  end

  def logged_in?
    # Implement your own authentication check
    session[:user_id].present?
  end

  def current_user
    # Implement your own current user method
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:alert] = "Please log in to access this page"
      redirect_to login_path
    end
  end
end
