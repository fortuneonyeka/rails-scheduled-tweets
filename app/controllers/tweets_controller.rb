class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = current_user.tweets.order(created_at: :desc)
  end

  def show
  end

  def scheduled
    @tweets = current_user.tweets.scheduled.order(scheduled_at: :asc)
    render :index  # Reuses your existing index view
  end
  def new
    @tweet = current_user.tweets.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    
    if @tweet.save
      redirect_to @tweet, notice: 'Tweet was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: 'Tweet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy
    redirect_to scheduled_tweets_path, notice: "Tweet was successfully deleted."
  end

  private

  def set_tweet
    @tweet = current_user.tweets.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content, :scheduled_at, :status)
  end
end
