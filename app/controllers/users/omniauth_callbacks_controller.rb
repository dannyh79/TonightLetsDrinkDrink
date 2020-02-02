# frozen_string_literal: true

# FIXME: Unify sign-in & flash logic
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = "認證成功"
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # 05 Jul., '19- Facebook would not whitelist our domain,
  # "https://tonight-lets-drink-drink.herokuapp.com", so the FB login
  # feature is taken out for now.

  # def facebook
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, event: :authentication

  #     return unless is_navigational_format?

  #     set_flash_message(:notice, :success, kind: "Facebook")
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  def failure
    redirect_to new_user_session_path, alert: "無法取得認證！"
  end
end
