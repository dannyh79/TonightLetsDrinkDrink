class RegistrationsController < Devise::RegistrationsController
  before_action :check_pwd_change, only: :update
  # prepend_before_action :authenticate_scope!, only: [:edit, :profile, :update, :destroy]
  before_action :set_profile, only: [:profile, :profile_update]

  def update
    super
  end

  def edit
    render :edit
  end

  def profile
    # byebug
    render :profile
  end

  def profile_update
    # byebug
    if current_user.update(profile_params)
      redirect_to calc_path
    end
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

  def profile_params
    params.require(:user).permit(:email, :gender, :weight, :password)
  end

  def set_profile
    @user = User.find_by(id: params[:id])
  end

end

# 屬性的寫法