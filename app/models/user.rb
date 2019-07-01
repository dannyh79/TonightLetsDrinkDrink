class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_defines

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
         # :google_oauth2 是在 controller 中設定的 instance method

  validates :email, :encrypted_password, :gender, :weight, presence: true

  # email
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([a-zA-Z]{2,})\z/i
  validates :email, uniqueness: true

  # password
  validates :password, length: { minimum: 6 }

  # weight
  validates :weight, numericality: { greater_than: 0 }

  has_many :user_defines
  has_one :identity, dependent: :destroy

  def self.from_omniauth(auth, signed_in_resource = nil)
    # data = access_token.info
    identity = Identity.find_for_auth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email = auth.info.email

      user = User.where(email: email).first if email

      if user.nil?
        user = User.new(email: auth.info.email,
                        # user.gender = auth.extra.raw_info.gender
                        # gender: auth.info.gender,
                        # weight: auth.info.weight,  # google 沒有體重欄，可能要再想一下...
                        # name: auth.info.name.gsub(/\s+/, '_'),
                        password: Devise.friendly_token[0, 20])

        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end

    user  # 不是很確定這邊 return user 的用意...

  end

  def delete_access_token(auth)
    @graph.delete_connections(auth.uid, "permissions")
  end

  def from_google?
    Identity.find_by(user_id: id).present?
  end
end
