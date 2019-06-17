class UserDefinesController < ApplicationController
  include CalcHelper

  # WIP: 尚未建立關聯性
  def edit
    @drinks = drinks
    # redirect_to (request.referer || root_path), notice: 'You have no records!' if not user_drinks
  end

  def destroy
    redirect_to edit_user_define_path, notice: '刪除成功'
  end
  
end