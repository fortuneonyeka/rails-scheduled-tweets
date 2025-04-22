module ApplicationHelper

def default_avatar_url
  "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
end



def tweet_status_badge_class(status)
  case status
  when 'scheduled' then 'bg-yellow-100 text-yellow-800'
  when 'published' then 'bg-green-100 text-green-800'
  when 'failed' then 'bg-red-100 text-red-800'
  else 'bg-gray-100 text-gray-800'
  end
end
end
