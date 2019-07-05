class Identity < ApplicationRecord
  belongs_to :user

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  # 如果第三方登入的資料已經存在就直接使用，沒有的話就用第三方授權來註冊新的並且登入
  def self.find_for_auth(auth)
    find_or_create_by uid: auth.uid, provider: auth.provider
  end

end
