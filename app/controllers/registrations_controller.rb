# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :check_pwd_change, only: :update
  before_action :set_profile,      only: %i[profile profile_update]

  def edit; end

  def profile; end

  def profile_update
    if current_user.from_3rd_party_login? || current_user.valid_password?(
      params[:user][:current_password]
    )
      current_user.update(profile_params)
      redirect_to calc_path, notice: '個人資料更改成功'
    else
      current_user.errors.add(:current_password, :invalid, message: '輸入錯誤')
      render :profile
    end
  end

  def update
    super
  end

  private

  def check_pwd_change
    @is_pwd_changed = params[:user][:password].present?
  end

  def profile_params
    params.require(:user).permit(:email, :gender, :weight, :password)
  end

  def set_profile
    @user = User.find_by(id: params[:id])
  end
end
