module TweetsHelper
  def tweet_status_badge_class(status)
    case status.to_sym
    when :draft then 'bg-gray-100 text-gray-800'
    when :scheduled then 'bg-blue-100 text-blue-800'
    when :published then 'bg-green-100 text-green-800'
    when :failed then 'bg-red-100 text-red-800'
    else 'bg-gray-100 text-gray-800'
    end
  end
end