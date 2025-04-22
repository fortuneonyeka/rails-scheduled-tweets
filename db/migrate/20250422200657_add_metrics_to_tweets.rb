class AddMetricsToTweets < ActiveRecord::Migration[8.0]
  def change
    add_column :tweets, :impressions_count, :integer
    add_column :tweets, :likes_count, :integer
    add_column :tweets, :retweets_count, :integer
  end
end
