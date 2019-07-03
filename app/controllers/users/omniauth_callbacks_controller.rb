class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  # 向第三方請求開放授權
  def google_oauth2
  
    # 向第三方請求認證，key 在 /config/application.yml
    @user = User.from_omniauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = "認證成功"  # 原為 i18n 的 notice
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url  # 設定 url 是給外部網站來做連結的
    end
  end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # 認證失敗
  def failure
    redirect_to new_user_session_path, alert: "無法取得認證！"
  end

end
