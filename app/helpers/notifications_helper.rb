module NotificationsHelper
  def create_notification(micropost:nil,visited:nil,action_name:nil)
    notification=current_user.active_notifications.new(micropost_id:micropost&.id,
                                                        visited_id:visited.id,
                                                        action:action_name)
    notification.save if notification.valid?
  end

  def delete_notification(micropost:nil,visited:nil,action_name:nil)
    notification=current_user.active_notifications.find_by(micropost_id:micropost&.id,visited_id:visited.id,action:action_name)
    notification.destroy if !notification.nil?
  end
end
