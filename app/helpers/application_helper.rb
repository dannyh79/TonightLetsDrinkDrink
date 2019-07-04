module ApplicationHelper

  def current_user_from_3rd_party_login?
    return false if current_user.nil?
    current_user.from_3rd_party_login?
  end
end
