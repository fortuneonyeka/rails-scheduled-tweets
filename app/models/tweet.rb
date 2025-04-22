class Tweet < ApplicationRecord
  belongs_to :user

  enum :status, {
  draft: 0,
  scheduled: 1,
  published: 2,
  failed: 3
}, default: :draft

  validates :content, presence: true, length: { maximum: 280 }
  validates :scheduled_at, presence: true, if: -> { scheduled? }

  scope :scheduled, -> { where(status: :scheduled).where("scheduled_at > ?", Time.current) }
end
