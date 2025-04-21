# app/jobs/user_session_cleanup_job.rb
class UserSessionCleanupJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    # Clear sessions for deleted user
    ActiveRecord::SessionStore::Session.where("user_id = ?", user_id).delete_all
  end
end
