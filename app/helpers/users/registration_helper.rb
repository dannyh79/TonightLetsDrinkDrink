# frozen_string_literal: true

# FIXME: Refector me w/ associated views
module Users::RegistrationHelper
  def set_gender
    return unless params[:user].try(:[], :gender)

    sanitize 'checked="checked"'
  end

  def male?
    return unless params[:user].present? && params[:user][:gender] == 'Male'

    sanitize 'checked="checked"'
  end

  def female?
    return unless params[:user].present? && params[:user][:gender] == 'Female'

    sanitize 'checked="checked"'
  end
end
