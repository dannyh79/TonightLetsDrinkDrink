class RegistrationsController < Devise::RegistrationsController
  before_action :check_pwd_change, only: :update
  before_action :set_profile, only: [:profile, :profile_update]

  def update
    super
  end

  def edit
    render :edit
  end

  def profile
    render :profile
  end

  def profile_update
    if current_user.valid_password?(params[:user][:current_password])
      current_user.update(profile_params)
      redirect_to calc_path, notice: '個人資料更改成功'
    else
      current_user.errors.add(:password, :invalid, message: '密碼輸入錯誤')
      render :profile
    end
  end

  protected

  def check_pwd_change
    @isPwdChanged = params[:user][:password].present?
  end

  def after_sign_up_path_for(resource)
    sign_out
    flash[:notice] = '註冊成功'
    new_user_session_path
  end
  
  def after_update_path_for(resource)
    if @isPwdChanged
      sign_out
      flash[:notice] = '密碼更新成功；請重新登入'
      new_user_session_path
    else
      calc_path
    end
  end

  def profile_params
    params.require(:user).permit(:email, :gender, :weight, :password)
  end

  def set_profile
    @user = User.find_by(id: params[:id])
  end

end