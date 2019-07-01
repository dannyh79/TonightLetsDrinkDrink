module ApplicationHelper

  def current_user_from_google?
    return false if current_user.nil?
    current_user.from_google?
  end
end
