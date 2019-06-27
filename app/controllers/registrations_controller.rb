class RegistrationsController < Devise::RegistrationsController
  before_action :check_pwd_change, only: :update

  def update
    super
  end

  def edit_info
    :edit
  end

  def update_info
    :update
  end

  # def update
  #   super
  #   @password_update = params[:user][:password]
  #   if @password_update.present?
  #     sign_out
  #     redirect_to new_user_session_path
  #   else
  #     redirect_to calc_path, notice: '更新成功'
  #   end
  # end

  protected

  def check_pwd_change
    # byebug
    @isPwdChanged = params[:user][:password].present?
  end

  def after_sign_up_path_for(resource)
    sign_out
    new_user_session_path
  end
  
  def after_update_path_for(resource)
    # byebug
    if @isPwdChanged
      sign_out
      new_user_session_path
    else
      calc_path
    end
  end
end

# 屬性的寫法