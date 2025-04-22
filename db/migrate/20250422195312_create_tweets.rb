class CreateTweets < ActiveRecord::Migration[8.0]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.datetime :scheduled_at
      t.integer :status, default: 0
      t.integer :impressions_count, default: 0
      t.integer :likes_count, default: 0
      t.integer :retweets_count, default: 0

      t.timestamps
    end
  end
end
